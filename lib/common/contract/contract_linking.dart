import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://192.168.31.180:8545";
  final String _wsUrl = "ws://192.168.31.180:8545/";
  final String _privateKey = "a9e25a6179a09123b00f827160db1b446c55b1910b0601803b901fe32fd0e161";

  late Web3Client _client; // 变量将用于在 WebSocket 的帮助下建立与以太坊 rpc 节点的连接。
  bool isLoading = true; // 变量将用于检查合约的状态。

  late String _abiCode; // 变量将用于读取合约 abi。
  late EthereumAddress _contractAddress; // 变量将用于存储已部署智能合约的合约地址。

  late Credentials _credentials; // 变量将存储智能合约部署者的凭据。

  late DeployedContract _contract; // 变量将用于告诉 Web3dart 我们的合约是在哪里声明的。
  late ContractFunction _yourName; //  变量将用于存储我们的 HelloWorld.sol 智能合约中声明的函数。
  late ContractFunction _setName; //  变量将用于存储我们的 HelloWorld.slate ol 智能合约中声明的函数。

  late String deployedName; // 将保存智能合约中的名称。


  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    print("init 1");
    // establish a connection to the ethereum rpc node. The socketConnector
    // property allows more efficient event streams over websocket instead of
    // http-polls. However, the socketConnector property is experimental.
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    print(_rpcUrl);
    print(_wsUrl);
    await getAbi();
    await getCredentials();
    await getDeployedContract();
    print("init 2");
  }

  Future<void> getAbi() async {
    // Reading the contract abi
    String abiStringFile =
    await rootBundle.loadString("src/artifacts/HelloWorld.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {

    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "HelloWorld"), _contractAddress);

    // Extracting the functions, declared in contract.
    _yourName = _contract.function("yourName");
    _setName = _contract.function("setName");
    getName();
  }

  getName() async {

    // Getting the current name declared in the smart contract.
    var currentName = await _client
        .call(contract: _contract, function: _yourName, params: []);
    deployedName = currentName[0];
    isLoading = false;
    notifyListeners();
  }

  setName(String nameToSet) async {

    // Setting the name to nameToSet(name defined by user)
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract, function: _setName, parameters: [nameToSet]));
    getName();
  }

}
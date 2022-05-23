pragma solidity ^0.5.0;

contract MyCoin {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;   //maping= asigna un saldo de un token a una dirección
    mapping (address => mapping (address => uint256)) public allowance;  //allowance: devuelve la cantidad que spender (el que gasata) aun puede retirar

        /*ALLOWANCE:permite que una dirección otorgue una asignación a otra dirección para poder recuperar tokens de ella.
        devuelve la cantidad restante de tokens que el gastador podrá gastar en nombre del propietario */

    constructor() public {
        name = "My coin" ;
        symbol = "MC";
        decimals = 18;
        totalSupply = 1000000 * (uint256(10) ** decimals);
        balanceOf [msg.sender] = totalSupply;  //devuelve el saldo de una cuenta
    }

    /*event: permite comunicarse con su smart contract desde su intefraz.
    Permiten un registro de la actividad*/
    event Transfer (address indexed _from, address indexed _to, uint256 _value);  
    event Approval (address indexed _owner, address indexed _spender, uint256 _value);

    function transfer (address _to, uint256 _value) public returns (bool success) {
        require (balanceOf [msg.sender] >= _value);  //msg.sender: remitente o TRANSMISOR del mensaje 
        balanceOf[msg.sender] -= _value;
        balanceOf [_to] += _value;
        emit Transfer (msg.sender, _to, _value);
        return true;
    }

    function approve (address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender] [_spender] = _value;
        emit Approval (msg.sender, _spender, _value);
        return true;
    }

    function transferFrom (address _from, address _to, uint256 _value) public returns (bool success) {
        require (balanceOf [_from] >= _value);
        require (allowance [_from] [msg.sender] >= _value);
        balanceOf [_from] -=_value;
        balanceOf [_to] += _value;
        allowance [_from] [msg.sender] -= _value;
        emit Transfer (_from, _to, _value);
        return true;
    }
}

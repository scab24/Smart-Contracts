pragma solidity ^0.5.0;

contract MyCoin {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;   //maping= asigna un saldo de un token a una dirección
    mapping (address => mapping (address => uint256)) public allowance;  //allowance: devuelve la cantidad que spender (el que gasata) aun puede retirar

    //Añadimos 3 variables de estado que van a llevar toda la dinámica de los dividendos
    uint256 dividendPerToken; //guarda el dividendo por token, pero el histórico o acumulado. Cuando haya un ingreso de beneficios se va a calcular el dividendo por token y se va a incrementar el que habia antes
    mapping(address => uint256) dividendBalanceOf; //Incrementamos todos los dividendos históricos
    mapping (address =>uint256) dividendCreditedTo; // es como el dividendPerToken (los token acumulados) pero que hayan sido usados para calcular los dividendBalanceOf de cada address

    function update (address _address) internal {  // función que actualice las 3 variables (dividendPerToken,dividendBalanceOf,dividendCreditedTo)
        uint256 debit = dividendPerToken - dividendCreditedTo[_address];  //TOTAL (-) USADO PARA CALCULAR BALANCES PENDIENTE DE LIQUIDADICIÓN
        dividendBalanceOf[_address] += balanceOf[_address] * debit;
        dividendCreditedTo[_address] = dividendPerToken;

    }

    //función para retirar fondos. Primero actualiza todas las variables y luego realiza la función
    function withdraw() public {
        update(msg.sender);   // pero antes actulizamos todas las variables
        uint256 amount= dividendBalanceOf [msg.sender];  //guardar en la variable amount la cantidad de dividendos que aúm no han sido liquidados para esa persona
        dividendBalanceOf[msg.sender] = 0;  //resetear el balance a 0 para que no se preoduzcan dobles gastos
        msg.sender.transfer(amount);  //balance que habia antes de resetearlo a 0

    }

    //función que permita ingresar los beneficios
    function deposit()public payable {
        dividendPerToken += msg.value / totalSupply;   //dividimos el beneficio entre el número total de tokens (beneficio por tojen)

    }


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
        update (msg.sender);
        update (_to);
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

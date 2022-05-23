pragma solidity ^0.5.0;

//necesitamos una interfaz para que nuestro token ERC20 interactue con nuestro contrato de venta (tokensale)
//La INTERFAZ se establece para poder comunicarte con un contrato ajeno al tuyo, para ello imiplementamos MÉTODOS

interface MyToken {  //marcar solo los métodos que vayamos a usar
    function decimals () external view returns (uint8);
    function balanceOf (address _address) external view returns (uint256);  //para obtener mapping de address a saldo
    function transfer (address _to, uint256 _value) external returns (bool success);

}  

contract TokenSale {
    address owner;
    uint256 price;
    MyToken myTokenContranct;
    uint256 tokensSold; //acumulativo de los token que está vendiendo este smart contract

    //para que se pueda recibir y leer el evento de una venta que se ha procesado
    event Sold(address buyer, uint256 amount);  //direccion del comprado y cantidad de tokens que ha comprado
    
    constructor (uint256 _price, address _addressContract) public {
        owner = msg.sender;
        price = _price;
        myTokenContranct = MyToken(_addressContract);

    } 

    //para solucionar agujeros de seguridad
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a==0) {
        return 0;
    }
    uint256 c=a*b;
    require(c/a==b);
    return c;
    }


    //funcion de COMPRA DE TOKEN
    function buy(uint256 _numTokens) public payable {
        require(msg.value == mul(price, _numTokens));
        uint256 scaledAmount = mul(_numTokens, uint256(10) ** myTokenContranct.decimals());  //scaledAmount= operación en el ERC20
        require (myTokenContranct.balanceOf(address(this)) >= scaledAmount);    //funcion ASOCIACION de tokens, comprabamos que tenga esos token que va a vender
        tokensSold += _numTokens;  //cuanta que lleva la contabilidad para sumarle. numTokens= operación en bruto y no en el ERC20
        require (myTokenContranct.transfer(msg.sender, scaledAmount)); //nos aseguramos que nos está retornando un true (linea 9); la operación se ha realizado exitosamente. (a quien se envia, cantidad escalada)
        emit Sold(msg.sender, _numTokens); //quien es el comrador y el número de tokens

    }
    
    //funcion de LIQUIDAR  el contrato para que no siga vendiendo lo que ya ha vendido
    function endSold() public {
        require (msg.sender == owner);
        require (myTokenContranct.transfer(owner, myTokenContranct.balanceOf(address(this)))); //dirección a quien se envia (to) y la cantidad. Con esto transferimos al dueño de este contrato todo el saldo de este smartcontract ded venta(la diferencia)
        msg.sender.transfer (address(this).balance);  //pasar al dueño el saldo en cuanto a ether. se transfiere lo que tenga este contrato
    }
    

}  

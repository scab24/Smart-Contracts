// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

//compra venta de una propiedad con garantia

contract Escrow {

    //dirección del pagador
    address public payer;

    //dirección del tenedor de la propiedad
    //es payble debido a que es el que recibe el dinero
    address payable public payee;

     //dirección del abogado
     address public lawyer;

     //cantidad de dinero
     uint public amount;

     //constructor del smart contract
    constructor (address _payer, address payable _payee, uint _amount) {

        payer = _payer;
        payee = _payee;
        lawyer = msg.sender;
        amount = _amount;
    }

    //función para depositar
    function deposit() payable public {
        require (msg.sender == payer, "sender debe ser el pagador");
        require (address (this).balance <= amount, "");

    }

    //función para liberar la propiedad una vez pagada

    function release() public {
        require (address(this).balance == amount, "No se puede liberar hasta que no se deposite el dinero");
        require (msg.sender == lawyer, "Solo el abogado puede liberar");
        payee.transfer (amount);
    }

    //obtener el balance de la billetera
    function balanceOf() view public returns (uint) {
        return address (this).balance;
    }



}

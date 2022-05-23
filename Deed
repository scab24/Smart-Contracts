// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

//Smart contract para hacer un trato o acuerdo con un tiempo estipulado para retirar el dinero

contract Deed {

    //Dirección del abogado
    address public lawyer;

    //Dirección del beneficiario
    address payable public beneficiary;

    //Establecer un tiempo estipulado
    uint public earliest;


    //constructor del smart contract
    constructor (address _lawyer, address payable _beneficiary, uint fromNow) payable {
        lawyer = _lawyer;
        beneficiary = _beneficiary;
        earliest = block.timestamp + fromNow;
    }

    //función para retirar el dinero con un tiempo estipulado (tiempo mínimo por cumplir)
    function withdraw() public {
        require (msg.sender == lawyer, "Solo puede enviar el dinero el abogado"); //el único que puede enviar el dinero es el lawyer
        require (block.timestamp >= earliest, "Es demasiado pronto para retirar el dinero");
        beneficiary.transfer (address (this).balance);  //transfiero a esta cuenta (del beneficiario)
    }

}

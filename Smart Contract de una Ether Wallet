// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

//Creación de un Smart contract de una billetera de ether.

contract etherWallet {
        //Dirección del propietario

            address public owner;

        //Constructor del Smart Contrac (declarar la variable de quien el el proipietario)

            constructor (address _owner) {   //O tambien function etherWallet(address _owner)
                owner = _owner;
            }

        //Función para depositar dinero (Ether)

            function deposit () payable public {

            }

        //Función de enviar dinero. Necesitamos una dirección y una cantidad de dinero
        //Cuando estamos enviando dinero siempre usar la variable 'payable'
        //if: Solo el propìetario de este smart contract (billetera) tenga el poder de enviar dinero

        function send (address payable to, uint amount) public {
            if (msg.sender == owner) {
                to.transfer (amount);
                return;
            }
            revert ("Esta cuenta no tiene permitido anviar dinero");
        }


        //Función para obtener el balance de la billetera

        function balanceof () view public returns (uint) {
            return address (this).balance;
        }

}        

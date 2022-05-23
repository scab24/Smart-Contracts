// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

//  Smart contract de almacenamiento de datos avanzado.

contract AdvanceStorage {
    
    //Necesitaremos un Array de los números / ids. 
    //Va a ser de función numérica(uint):para crear un array. ids= nombre que le damos

    uint [] public ids;

    //Necesitamos una función paraañadir estos números / ids.
    //add de añadir, uint_: como lo vamos a llamar, y lo decaramos como _id
    // ids.push: para añadir un número dentro del id

    function add (uint _id) public{
        ids.push (_id);
    }
    //Necesitamos una función para obtener el número o id, indicando la posicón del número. posición en función del número
    // uin: posición del array de forma numérica, lo declaramos como variable _position
    // Nos va a retornar un número por tanto ponemos un uint (un isd en función de la posición)

    function get (uint _position) view public returns (uint) {
        return ids [_position];
    }

    //Necesitamos una función para obtener todos los números o ids introducidos
    //Para hacer return dentro de una función de una variable más avanzada necesitamos añadir "memory"
    //Para que nos retorne un aaray numérico necesitamos poner uint. View public: función pública

    function getAll () view public returns (uint[] memory) {  //memory: quiere decir qeu se guarda temporalmente en la memoria. storage: para que se guarde permanentamente
        return ids;
    }

    //Necesitamos una función para obtener cuantos números o ids hay introducidos dentro del array.

    function length () view public returns (uint) {
        return ids.length;
    } 

}

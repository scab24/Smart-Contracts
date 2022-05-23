// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

// Crear aplicación CRUD : CREATE / READ / UPDATE / DELETE

contract CRUD {

        //Creamos la estructura de un usuario
        // Un id de forma numérica (uint) y un nombre en forma de string

        struct User {
            uint id;
            string name;
        }

         //Necesitamos una lista - array dónde guardemos los usuarios que vayamos creando
         // La lista va a ser de nuestra estructura User, para crear el array añadimos [] y la llamamos users

         User [] users;


         //Creamos próximo id del usuario, cada vez que se cree un usuario se cree un nuevo id

         uint nextId;

         //Necesitamos la función para crear un usuario
         //Un string siempre va acompañado de memory 
         //.push: para hacer la introducción del usuario que estamos creando
         //Indicamos para que vaya 1 a 1 en la lista. NextId++: para que me cree el próximo Id

         function create (string memory _name) public {
             users.push (User (nextId, _name));
             nextId++;
         }

         //Función para BUSCAR scar el id del usuario
         //Para ello necistamos implementar un loop para recorrerse la lista de usuarios en busca de cada uno de los usuarios
         //Para luego utilizarlo en cada una de las funciones (buscar, actualizar, eliminar)
        // find (indicamos lo que queremos buscar)
         function find (uint id) view internal returns (uint) {
             for (uint i = 0; i < users.length; i++) {
                 if (users [i].id == id) {
                     return i;
                 }
             }
             revert ('EL USUARIO NO EXISTE');
         }
 


         //Necesitamos una función para obtener-LEER los datos de un usuario através de indicarle el id
         //en esta función quiero que utilice la función de BUSCAR ID
         function read (uint _id) view public returns (uint, string memory) {
             uint i = find (_id);  //quiero que busque el id de este usuario y lo retorne
             return (users [i].id, users [i].name);

         }
         //Función de actualizar (el usuario)
         //update(le indicamos lo que queremos que actualice)
         function update (uint _id, string memory _name) public {
             uint i = find (_id);
             users [i].name = _name;  //actualizamos el nombre dentro de nuestra lista
         }


         //Función de eliminar

         function destroy (uint _id) public {
             uint i = find (_id);
             delete users [i];  //Nos elimina el usuario que le hemos indicado
         }


}

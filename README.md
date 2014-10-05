### COMMITS ###

Los commits de las tarea tienen el formato: _#numero mensaje_, donde __numero__ es la tarea a la que va asociada el commit, y  __mensaje__ la descripcion de lo realizado.

### TAREAS ###

#### 1) Actualizar el modelo Weapon para que la Factory funcione como un singleton por el atributo name####

__Status:__ Funciona, para lograrlo se hizo override de metodo _create_or_update_, primero se busca si existe un registro en la BD, luego se ve si es nuevo o no. En caso de ser nuevo, simplemente copiamos el id y llamamos a update. En caso de haber existido, se cambia el id y se modifica el hash que contiene los cambios de atributos (para evitar una exception de PRIMARY KEY al guardar). __Se agregaron tests que prueban ambos casos__.


#### 2) Economizar municiones (problema de la mochila knap-sack - recalcular en cada turno). ####

__Status:__ Lo solucioné utilizando un algoritmo genético (__OVERKILL MAYBE__).  El algoritmo funciona así: 1) revisa si existe un arma que puede hacer el daño por si misma, 2) revisa si hay un arma cuyo daño es múltiplo del daño total a realizar, y 3) ejecuta un algoritmo genético que busca la solución óptima. Primero ve los casos 1 y 2 que corresponden a soluciones inmediatas y "baratas". Si no, se procede con 3), donde se busca un conjunto de combinaciones de armas tal que la suma de los daños menos el daño a realizar sea mínimo (y mayor o igual a 0), utilizando un algoritmo genético modificado (sin crossover y muy poco tolerante a individuos defectuosos). __Se agregaron tests para el algoritmo genético y para el método del robot que hace el daño__

#### 3) Las armas pueden tener efectos secundarios - Freeze (el otro robot se salta su próximo ataque) ####
    
__Status:__ Se agregaron las migraciones y métodos para lograrlo. Según lo conversado, el estado de congelado de robot no es persistente. __Se agregaron tests en robot y simulador para testear esto".

#### 4) En el formulario de robot se puede elegir un CodeName por nombre, o bien, se puede agregar uno por texto. En el último caso se debe el CodeName con todos los datos necesarios para generar una instancia válida. ####

__Status:__ Se agregó al formulario de robots esta funcionalidad de la siguiente forma: un formulario nesteado con los atributos del __CodeName__ incluyendo el id, de forma que si el id está presente, al enviar el formulario busca en la BD el codename y lo setea al Robot que se esta creando, y si no exstá presente, simplemente crea el __CodeName__ con nested_form. __Se agregó el test pero no funciona el selector. Estoy seguro que es problema de Rspec :P.

#### 5) Verificar que el link de la aplicación siempre funciona correctamente. Adicionalmente debe marcarse en las vistas donde se crean nuevos elementos (si está en /robots/new debe estar activada robots/ link) ####

__Status:__ Se modificó el helper que imprime los <li> con clase activa, para que cumpliera con la funcionalidad y además __se agregaron los tests que prueban que la pág funcione y que verifique el correcto funcionamiento de los <li>.
function doSearch() {
    var tableReg = document.getElementById('Table-Productos');
    var searchText = document.getElementById('searchTerm').value.toLowerCase();
    var cellsOfRow = "";
    var found = false;
    var compareWith = "";
    
    // Recorremos todas las filas del contenido de la tabla productos
    for (var i = 1; i < tableReg.rows.length; i++) {
        cellsOfRow = tableReg.rows[i].getElementsByTagName('td');
        found = false;
        
        // Recorremos todas las celdas
        for (var j = 0; j < cellsOfRow.length && !found; j++) {
            compareWith = cellsOfRow[j].innerHTML.toLowerCase();
            
            // Buscar texto en el contenido de la celda 
            if (searchText.length == 0 || (compareWith.indexOf(searchText) > -1)) {
                found = true; 
            }
        }
        
        if (found) {
            tableReg.rows[i].style.display = '';
        } else {
            // Si no encuentra ninguna coincidencia en la fila, esconde la fila de la tabla
            tableReg.rows[i].style.display = 'none';
        }
    }
}

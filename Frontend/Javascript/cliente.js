document.addEventListener("DOMContentLoaded", function () {
    const content = document.getElementById('content');
    content.innerHTML = `
        <h1>Gestión Clientes</h1>
        <div class="form-container" style="display: flex; flex-direction: column; align-items: flex-start; gap: 10px; margin-bottom: 20px;">
            <input type="text" id="nombre" placeholder="Nombre" style="width: 300px; padding: 5px; box-sizing: border-box;">
            <input type="text" id="apellido" placeholder="Apellido" style="width: 300px; padding: 5px; box-sizing: border-box;">
            <input type="tel" id="telefono" placeholder="Teléfono" style="width: 300px; padding: 5px; box-sizing: border-box;">
            <input type="email" id="email" placeholder="Email" style="width: 300px; padding: 5px; box-sizing: border-box;">
            <button id="agregar" style="padding: 10px 15px; cursor: pointer;">Agregar</button>
        </div>
        <div class="table-container">
            <table style="width: 100%; border-collapse: collapse; text-align: left; margin: 20px 0; font-size: 12px;">
                <thead style="background-color: #f4f4f4;">
                    <tr>
                        <th style="padding: 10px; border: 1px solid #ddd;">Nombre</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Apellido</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Teléfono</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Email</th>
                        <th style="padding: 10px; border: 1px solid #ddd;">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tablagestion">
                    <tr>
                        <td style="padding: 10px; border: 1px solid #ddd;">Juan</td>
                        <td style="padding: 10px; border: 1px solid #ddd;">Pérez</td>
                        <td style="padding: 10px; border: 1px solid #ddd;">123456789</td>
                        <td style="padding: 10px; border: 1px solid #ddd;">juan.perez@example.com</td>
                        <td style="padding: 10px; border: 1px solid #ddd;">
                            <button onclick="editarFila(this)" style="background: none; border: none; cursor: pointer;">
                                ✏️
                            </button>
                            <button onclick="eliminarFila(this)" style="background: none; border: none; cursor: pointer; margin-left: 10px;">
                                🗑️
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    `;

    // Función para editar una fila
    window.editarFila = function (boton) {
        const fila = boton.closest('tr');
        const celdas = fila.querySelectorAll('td:not(:last-child)');
        celdas.forEach((celda) => {
            const valor = celda.textContent;
            celda.innerHTML = `<input type="text" value="${valor}" style="width: 100%; box-sizing: border-box;">`;
        });
        boton.textContent = "💾";
        boton.onclick = function () {
            celdas.forEach((celda) => {
                const input = celda.querySelector('input');
                if (input) celda.textContent = input.value;
            });
            boton.textContent = "✏️";
            boton.onclick = () => editarFila(boton);
        };
    };

    // Función para eliminar una fila
    window.eliminarFila = function (boton) {
        const fila = boton.closest('tr');
        fila.remove();
    };

    // Función para agregar una nueva fila
    document.getElementById('agregar').addEventListener('click', function () {
        const nombre = document.getElementById('nombre').value.trim();
        const apellido = document.getElementById('apellido').value.trim();
        const telefono = document.getElementById('telefono').value.trim();
        const email = document.getElementById('email').value.trim();

        if (nombre && apellido && telefono && email) {
            const nuevaFila = `
                <tr>
                    <td style="padding: 10px; border: 1px solid #ddd;">${nombre}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${apellido}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${telefono}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">${email}</td>
                    <td style="padding: 10px; border: 1px solid #ddd;">
                        <button onclick="editarFila(this)" style="background: none; border: none; cursor: pointer;">
                            ✏️
                        </button>
                        <button onclick="eliminarFila(this)" style="background: none; border: none; cursor: pointer; margin-left: 10px;">
                            🗑️
                        </button>
                    </td>
                </tr>
            `;
            document.getElementById('tablagestion').insertAdjacentHTML('beforeend', nuevaFila);

            // Limpiar campos después de agregar
            document.getElementById('nombre').value = '';
            document.getElementById('apellido').value = '';
            document.getElementById('telefono').value = '';
            document.getElementById('email').value = '';
        } else {
            alert('Por favor, completa todos los campos antes de agregar.');
        }
    });
});

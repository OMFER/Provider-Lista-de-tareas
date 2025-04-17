const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

app.use(bodyParser.json());
app.use(cors());

let tareas = [
    { id: 1, titulo: "Tarea de ejemplo", descripcion: "Esta es una tarea de ejemplo", completada: false }
  ];

app.get('/tareas', (req, res) => {
    res.json(tareas);
});

app.post('/tareas', (req, res) => {
    const nuevaTarea = {
        id: tareas.length > 0 ? Math.max(...tareas.map(t => t.id)) + 1 : 1,
        titulo: req.body.titulo || '',
        descripcion: req.body.descripcion || '',
        completada: req.body.completada || false
    };
    tareas.push(nuevaTarea);
    //res.json(tareas);
    res.status(201).json(nuevaTarea);
});

app.put('/tareas/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const index = tareas.findIndex(t => t.id === id);
    
    if (index === -1) {
      return res.status(404).json({ error: 'Tarea no encontrada' });
    }

    const updatedTarea = {
        id: id,
        titulo: req.body.titulo || tareas[index].titulo,
        descripcion: req.body.descripcion || tareas[index].descripcion,
        completada: req.body.completada !== undefined ? req.body.completada : tareas[index].completada
    };
  
    tareas[index] = updatedTarea;
     res.json(updatedTarea);
  });

app.delete('/tareas/:id', (req, res) => {
  const id = req.params.id;
  tareas = tareas.filter(t => t.id !== id);
  res.status(204).send();
});

app.listen(3000, () => {
    console.log('Servidor iniciado en el puerto 3000');
});
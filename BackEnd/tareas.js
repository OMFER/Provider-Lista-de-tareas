const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

app.use(bodyParser.json());
app.use(cors());

let tareas = [
    { id: 1, titulo: "Tarea de ejemplo", descripcion: "Esta es una tarea de ejemplo", completada: false }
  ];

const router = express.Router();
app.use(router);

app.get('/tareas', (req, res) => {
    res.json(tareas);
});

app.post('/tareas', (req, res) => {
    const nuevaTarea = {
        id: 5,
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
  
    tareas[index] = { ...tareas[index], ...req.body };
    res.json(tareas[index]);
  });

app.delete('/tareas/:id', (req, res) => {
    const id = req.params.id;
    tareas = tareas.filter(t => t.id !== id);
  res.status(204).send();
});

app.listen(3000, () => {
    console.log('Servidor iniciado en el puerto 3000');
});
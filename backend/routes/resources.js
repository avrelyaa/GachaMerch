const express = require('express');
const router = express.Router();
const db = require('../db');
const { verifyToken, verifyAdmin } = require('../middleware/auth');

router.get('/', (req, res) => {
  db.query('SELECT * FROM resources ORDER BY created_at DESC', (err, results) => {
    if (err) return res.status(500).json({ message: 'Failed to fetch resources.', error: err.message });
    res.json(results);
  });
});

router.get('/:id', verifyToken, (req, res) => {
  db.query('SELECT * FROM resources WHERE id = ?', [req.params.id], (err, results) => {
    if (err) return res.status(500).json({ message: 'Failed to fetch resource.', error: err.message });
    if (results.length === 0) return res.status(404).json({ message: 'Resource not found.' });
    res.json(results[0]);
  });
});

router.post('/', verifyAdmin, (req, res) => {
  const { id, name, type, description, stock, image, price } = req.body;

  if (!id || !name || !type || !description || stock === undefined || !image || !price) {
    return res.status(400).json({ message: 'All fields (id, name, type, description, stock, price) are required.' });
  }
  if (isNaN(stock) || stock < 0) {
    return res.status(400).json({ message: 'Stock must be a non-negative number.' });
  }
  if (isNaN(price) || price <= 0) {
    return res.status(400).json({ message: 'Price must be a positive number.' });
  }

  const sql = 'INSERT INTO resources (id, name, type, description, stock, image, price) VALUES (?, ?, ?, ?, ?, ?, ?)';
  db.query(sql, [id, name, type, description, stock, image || null, price], (err, result) => {
    if (err) {
      if (err.code === 'ER_DUP_ENTRY') return res.status(409).json({ message: 'Resource ID already exists.' });
      return res.status(500).json({ message: 'Failed to create resource.', error: err.message });
    }
    res.status(201).json({ message: 'Resource created successfully.', id });
  });
});

router.put('/:id', verifyAdmin, (req, res) => {
  const { name, type, description, stock, image, price } = req.body;

  if (!id || !name || !type || !description || stock === undefined || !image || !price) {
    return res.status(400).json({ message: 'All fields (name, type, description, stock, price) are required.' });
  }
  if (isNaN(stock) || stock < 0) {
    return res.status(400).json({ message: 'Stock must be a non-negative number.' });
  }
  if (isNaN(price) || price <= 0) {
    return res.status(400).json({ message: 'Price must be a positive number.' });
  }

  const sql = 'UPDATE resources SET name=?, type=?, description=?, stock=?, image=?, price=? WHERE id=?';
  db.query(sql, [name, type, description, stock, image || null, price, req.params.id], (err, result) => {
    if (err) return res.status(500).json({ message: 'Failed to update resource.', error: err.message });
    if (result.affectedRows === 0) return res.status(404).json({ message: 'Resource not found.' });
    res.json({ message: 'Resource updated successfully.' });
  });
});

router.delete('/:id', verifyAdmin, (req, res) => {
  db.query('DELETE FROM resources WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ message: 'Failed to delete resource.', error: err.message });
    if (result.affectedRows === 0) return res.status(404).json({ message: 'Resource not found.' });
    res.json({ message: 'Resource deleted successfully.' });
  });
});

module.exports = router;
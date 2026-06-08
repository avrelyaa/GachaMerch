const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
const db = require('../db');
require('dotenv').config();

function generateTokenId() {
  return crypto.randomBytes(16).toString('hex');
}

function generateToken(user) {
  const tokenId = generateTokenId();
  return jwt.sign(
    { id: user.id, username: user.username, role: user.role, jti: tokenId },
    process.env.JWT_SECRET,
    { expiresIn: '7d' }
  );
}

router.post('/register', (req, res) => {
  const { username, email, password, role } = req.body;

  if (!username || !email || !password) {
    return res.status(400).json({ message: 'Username, email, and password are required.' });
  }

  const hashedPassword = bcrypt.hashSync(password, 10);
  const userRole = role === 'admin' ? 'admin' : 'user';

  const sql = 'INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)';
  db.query(sql, [username, email, hashedPassword, userRole], (err, result) => {
    if (err) {
      if (err.code === 'ER_DUP_ENTRY') {
        return res.status(409).json({ message: 'Username or email already exists.' });
      }
      return res.status(500).json({ message: 'Registration failed.', error: err.message });
    }
    res.status(201).json({ message: 'User registered successfully.', userId: result.insertId });
  });
});

router.post('/login', (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: 'Email and password are required.' });
  }

  const sql = 'SELECT * FROM users WHERE email = ?';
  db.query(sql, [email], (err, results) => {
    if (err) return res.status(500).json({ message: 'Login failed.', error: err.message });
    if (results.length === 0) return res.status(401).json({ message: 'Invalid email or password.' });

    const user = results[0];
    const isMatch = bcrypt.compareSync(password, user.password);
    if (!isMatch) return res.status(401).json({ message: 'Invalid email or password.' });

    const token = generateToken(user);
    res.json({
      message: 'Login successful.',
      token,
      user: { id: user.id, username: user.username, email: user.email, role: user.role },
    });
  });
});

router.post('/google', (req, res) => {
  const { email, username, googleId } = req.body;

  if (!email || !username || !googleId) {
    return res.status(400).json({ message: 'email, username, and googleId are required.' });
  }

  
  db.query('SELECT * FROM users WHERE email = ?', [email], (err, results) => {
    if (err) return res.status(500).json({ message: 'Server error.', error: err.message });

    if (results.length > 0) {
      const user = results[0];
      const token = generateToken(user);
      return res.json({
        message: 'Google login successful.',
        token,
        user: { id: user.id, username: user.username, email: user.email, role: user.role },
      });
    }

    const randomPassword = bcrypt.hashSync(crypto.randomBytes(16).toString('hex'), 10);
    const sql = 'INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)';
    db.query(sql, [username, email, randomPassword, 'user'], (err, result) => {
      if (err) return res.status(500).json({ message: 'Registration failed.', error: err.message });

      const newUser = { id: result.insertId, username, email, role: 'user' };
      const token = generateToken(newUser);
      res.status(201).json({
        message: 'Google login successful.',
        token,
        user: newUser,
      });
    });
  });
});

module.exports = router;
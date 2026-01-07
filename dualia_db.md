# DB SCHEMA

## Table name: dualia (entity name: _dualia_)

### UTENTE

- id_utente INT AUTO_INCREMENT **PRIMARY KEY**
- nome VARCHAR(50) NOT NULL
- cognome VARCHAR(50) NOT NULL
- email VARCHAR(100) UNIQUE NOT NULL
- password VARCHAR(150) NOT NULL
- indirizzo VARCHAR(150) NOT NULL

### PRODOTTO

- id_prodotto INT AUTO_INCREMENT **PRIMARY KEY**
- nome VARCHAR(50) NOT NULL
- descrizione TEXT NOT NULL
- prezzo DECIMAL(10,2) NOT NULL
- qta_prodotto INT NULL
- colore VARCHAR(50) NULL
- dimensioni VARCHAR(50) NOT NULL
- id_categoria INT _FOREIGN KEY_

### CATEGORIA

- id_categoria INT AUTO_INCREMENT **PRIMARY KEY**
- nome VARCHAR(50) NOT NULL
- descrizione TEXT NULL

### CARRELLO

- id_carrello INT AUTO_INCREMENT **PRIMARY KEY**
- id_utente _FOREIGN KEY_
- qta INT NOT NULL

### ORDINE

- id_ordine INT AUTO_INCREMENT **PRIMARY KEY**
- id_utente _FOREIGN KEY_
- data DATE NOT NULL
- totale DECIMAL(10,2) NOT NULL
- stato VARCHAR(50) NOT NULL

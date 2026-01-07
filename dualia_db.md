# DB SCHEMA

## Table name: dualia (entity name: _dualia_)

### UTENTE

- id_utente (PK)
- nome
- cognome
- email
- password
- indirizzo

### PRODOTTO

- id_prodotto (PK)
- nome
- descrizione
- prezzo
- qta_prodotto
- colore
- id_categoria (FK)

### CATEGORIA

- id_categoria (PK)
- nome
- descrizione

### CARRELLO

- id_carrello (PK)
- id_utente (FK)
- qta

### ORDINE

- id_ordine (PK)
- id_utente (FK)
- data
- totale
- stato

# Analisi SQL di una Piattaforma di Ride Sharing

## Descrizione del progetto

Questo progetto raccoglie una serie di query SQL sviluppate su un database simulato di una piattaforma di ride sharing simile a Uber o Lyft.

L'obiettivo è mostrare l'utilizzo progressivo di SQL, partendo dalle operazioni di esplorazione dei dati fino ad arrivare ad analisi più avanzate mediante funzioni finestra (window functions).

Le query sono organizzate in tre sezioni:

1. Query di base per l'esplorazione dei dati.
2. Query intermedie per analisi e aggregazioni.
3. Query avanzate basate su window functions.

Il progetto è stato realizzato con finalità didattiche e di portfolio, con l'obiettivo di consolidare competenze SQL utili per ruoli di Data Analyst.

---

## Dataset

Il database rappresenta una piattaforma di ride sharing e contiene informazioni relative a:

- Utenti
- Rider
- Driver
- Corse (Trips)
- Pagamenti
- Recensioni
- Cancellazioni
- Località e zone operative

Le analisi coprono aspetti quali:

- Attività degli utenti
- Prestazioni dei driver
- Comportamento dei rider
- Ricavi e pagamenti
- Cancellazioni
- Andamento temporale delle corse

---

# Sezione 1

## Obiettivo

La prima sezione è dedicata all'esplorazione iniziale del database e all'utilizzo delle principali istruzioni SQL.

Queste query permettono di comprendere la struttura dei dati e di ottenere statistiche descrittive semplici.

## Concetti SQL utilizzati

- SELECT
- WHERE
- ORDER BY
- LIMIT
- DISTINCT
- COUNT()
- MIN()
- GROUP BY
- HAVING
- Gestione dei valori NULL
- Funzioni sulle date tramite STRFTIME()

## Esempi di analisi svolte

- Visualizzazione delle prime corse registrate.
- Conteggio degli utenti presenti nel database.
- Individuazione delle corse cancellate.
- Identificazione dei driver inattivi.
- Analisi dei metodi di pagamento utilizzati.
- Ricerca delle corse più costose.
- Individuazione delle recensioni con valutazione massima.
- Analisi dei rider e dei driver in base alla data di registrazione.

Questa sezione rappresenta il livello fondamentale di SQL e costituisce la base per le analisi successive.

---

# Sezione 2

## Obiettivo

La seconda sezione introduce analisi più vicine a scenari aziendali reali.

Le query combinano dati provenienti da più tabelle e permettono di calcolare indicatori di performance, ricavi e comportamenti degli utenti.

## Concetti SQL utilizzati

- INNER JOIN
- LEFT JOIN
- GROUP BY
- HAVING
- Subquery
- Common Table Expressions (CTE)
- CASE WHEN
- Funzioni aggregate:
  - COUNT()
  - SUM()
  - AVG()
  - MIN()
- Funzioni temporali:
  - STRFTIME()
  - JULIANDAY()

## Esempi di analisi svolte

### Analisi dei ricavi

- Ricavo totale per mese.
- Ricavo generato dalle diverse zone di partenza.
- Spesa complessiva dei rider.

### Analisi dei driver

- Driver con il maggior numero di corse completate.
- Driver con cancellazioni.
- Driver che non hanno mai ricevuto valutazioni inferiori a 3.

### Analisi dei rider

- Rider che hanno viaggiato in più città.
- Rider che non hanno mai lasciato recensioni.
- Rider con elevata spesa totale.

### Analisi operative

- Percentuale di corse cancellate.
- Distribuzione del surge multiplier.
- Tempo medio di attesa per città.
- Orario con il maggior numero di richieste.

Questa sezione mostra la capacità di trasformare dati grezzi in informazioni utili per il monitoraggio delle performance aziendali.

---

# Sezione 3

## Obiettivo

La terza sezione è dedicata alle window functions, uno degli strumenti più potenti di SQL per l'analisi dei dati.

A differenza delle normali aggregazioni, le window functions permettono di effettuare calcoli mantenendo il dettaglio delle singole osservazioni.

## Concetti SQL utilizzati

### Ranking Functions

- ROW_NUMBER()
- RANK()
- DENSE_RANK()

### Analisi temporali

- LAG()

### Aggregazioni cumulative

- SUM() OVER()

### Medie mobili

- AVG() OVER()

### Partizionamento e ordinamento

- PARTITION BY
- ORDER BY nelle finestre analitiche

## Esempi di analisi svolte

### Ranking

- Classifica dei driver in base ai ricavi generati.
- Individuazione della corsa più costosa per ogni rider.

### Analisi temporale

- Tempo trascorso tra due corse consecutive dello stesso driver.
- Individuazione della corsa più recente per ciascun driver.

### Metriche cumulative

- Guadagni cumulativi dei driver nel tempo.

### Rolling Analysis

- Media mobile a 7 giorni del numero di corse completate.

### Analisi delle ultime osservazioni

- Calcolo della tariffa media delle ultime tre corse di ciascun driver.

Questa sezione dimostra l'utilizzo di tecniche SQL avanzate frequentemente richieste nelle attività di Business Intelligence e Data Analysis.

---

# Competenze SQL dimostrate

Attraverso questo progetto vengono utilizzate le seguenti funzionalità SQL:

- Data exploration
- Data filtering
- Sorting
- Aggregazioni
- Raggruppamenti
- Analisi temporali
- Join tra tabelle
- Subquery
- Common Table Expressions (CTE)
- Conditional logic (CASE WHEN)
- Window Functions
- Ranking
- Running Totals
- Rolling Averages

---

# Strumenti utilizzati

- SQL
- MySQL
---

# Finalità del progetto

Questo progetto è stato realizzato come esercizio pratico per consolidare competenze SQL applicate all'analisi dei dati.

L'obiettivo è simulare attività tipiche di un Data Analyst, tra cui:

- Esplorazione dei dati.
- Costruzione di KPI.
- Analisi dei ricavi.
- Analisi del comportamento degli utenti.
- Analisi delle performance operative.
- Utilizzo di tecniche avanzate di SQL analytics.

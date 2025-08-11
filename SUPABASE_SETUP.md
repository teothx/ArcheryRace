# Configurazione Supabase per ArrowClash

Questa guida spiega come configurare Supabase per l'autenticazione e il salvataggio dei risultati di gioco in ArrowClash.

## Prerequisiti

1. Account Supabase (gratuito su [supabase.com](https://supabase.com))
2. Progetto Supabase creato

## Configurazione

### 1. Configurazione del Database

1. Accedi al tuo progetto Supabase
2. Vai alla sezione "SQL Editor"
3. Esegui lo script `supabase_setup.sql` incluso nel progetto

### 2. Configurazione delle Credenziali

1. Nel tuo progetto Supabase, vai su "Settings" > "API"
2. Copia l'URL del progetto e la chiave anonima
3. Aggiorna il file `lib/utils/supabase_config.dart` con le tue credenziali:

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'TUO_SUPABASE_URL';
  static const String supabaseAnonKey = 'TUA_SUPABASE_ANON_KEY';
}
```

### 3. Configurazione dell'Autenticazione

L'autenticazione è già configurata per utilizzare:
- Email/Password per login e registrazione
- Row Level Security per la sicurezza dei dati
- Gestione automatica delle sessioni

### 4. Schema del Database

#### Tabella `games`
- `id`: UUID primario
- `user_id`: Riferimento all'utente autenticato
- `game_type`: Tipo di gioco (duo, classica, bull, impact, solo)
- `date`: Data e ora del gioco
- `participants`: Array dei nomi dei partecipanti
- `totals`: Punteggi totali in formato JSON
- `scores`: Punteggi dettagliati per volley in formato JSON
- `created_at`, `updated_at`: Timestamp di creazione e aggiornamento

## Funzionalità Implementate

### Autenticazione
- ✅ Login con email/password
- ✅ Registrazione nuovi utenti
- ✅ Logout
- ✅ Controllo stato autenticazione
- ✅ Gestione errori

### Gestione Giochi
- ✅ Salvataggio risultati su cloud
- ✅ Caricamento cronologia giochi
- ✅ Sicurezza dati (RLS)
- ✅ Backup automatico

## Vantaggi dell'Integrazione Supabase

1. **Sicurezza**: Autenticazione robusta e Row Level Security
2. **Scalabilità**: Database PostgreSQL gestito
3. **Sincronizzazione**: Dati accessibili da qualsiasi dispositivo
4. **Backup**: Dati al sicuro nel cloud
5. **Performance**: Ottimizzazioni automatiche del database

## Risoluzione Problemi

### Errori di Connessione
- Verifica che URL e chiave API siano corretti
- Controlla la connessione internet
- Verifica che il progetto Supabase sia attivo

### Errori di Autenticazione
- Controlla che l'email sia valida
- Verifica che la password rispetti i requisiti
- Controlla i log di Supabase per errori dettagliati

### Errori di Database
- Verifica che lo script SQL sia stato eseguito correttamente
- Controlla che le policy RLS siano attive
- Verifica i permessi dell'utente

## Sviluppi Futuri

- [ ] Statistiche avanzate
- [ ] Classifiche globali
- [ ] Condivisione risultati
- [ ] Modalità multiplayer online
- [ ] Notifiche push
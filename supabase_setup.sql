-- Script SQL per configurare il database Supabase per ArrowClash
-- Eseguire questo script nell'SQL Editor di Supabase

-- Tabella per i giochi
CREATE TABLE IF NOT EXISTS games (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  game_type TEXT NOT NULL,
  date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  participants TEXT[] NOT NULL,
  totals JSONB NOT NULL,
  scores JSONB NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Abilita Row Level Security per la tabella games
ALTER TABLE games ENABLE ROW LEVEL SECURITY;

-- Rimuovi le policy esistenti se presenti
DROP POLICY IF EXISTS "Users can view own games" ON games;
DROP POLICY IF EXISTS "Users can insert own games" ON games;
DROP POLICY IF EXISTS "Users can update own games" ON games;
DROP POLICY IF EXISTS "Users can delete own games" ON games;

-- Policy per permettere agli utenti di vedere solo i propri giochi
CREATE POLICY "Users can view own games" ON games
  FOR SELECT USING (auth.uid() = user_id);

-- Policy per permettere agli utenti di inserire i propri giochi
CREATE POLICY "Users can insert own games" ON games
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Policy per permettere agli utenti di aggiornare i propri giochi
CREATE POLICY "Users can update own games" ON games
  FOR UPDATE USING (auth.uid() = user_id);

-- Policy per permettere agli utenti di eliminare i propri giochi
CREATE POLICY "Users can delete own games" ON games
  FOR DELETE USING (auth.uid() = user_id);

-- Indici per migliorare le performance
CREATE INDEX IF NOT EXISTS idx_games_user_id ON games(user_id);
CREATE INDEX IF NOT EXISTS idx_games_date ON games(date DESC);
CREATE INDEX IF NOT EXISTS idx_games_game_type ON games(game_type);

-- Funzione per aggiornare automaticamente updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Rimuovi il trigger esistente se presente
DROP TRIGGER IF EXISTS update_games_updated_at ON games;

-- Trigger per aggiornare automaticamente updated_at
CREATE TRIGGER update_games_updated_at BEFORE UPDATE ON games
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Vista per statistiche utente
CREATE OR REPLACE VIEW user_game_stats
WITH (security_invoker=true) AS
SELECT 
  user_id,
  COUNT(*) as total_games,
  COUNT(DISTINCT game_type) as game_types_played,
  MIN(date) as first_game_date,
  MAX(date) as last_game_date,
  game_type,
  COUNT(*) as games_per_type
FROM games
GROUP BY user_id, game_type;

-- Commenti per documentazione
COMMENT ON TABLE games IS 'Tabella per memorizzare i risultati dei giochi di ArrowClash';
COMMENT ON COLUMN games.game_type IS 'Tipo di gioco: duo, classica, bull, impact, solo';
COMMENT ON COLUMN games.participants IS 'Array dei nomi dei partecipanti';
COMMENT ON COLUMN games.totals IS 'Punteggi totali per partecipante in formato JSON';
COMMENT ON COLUMN games.scores IS 'Punteggi dettagliati per volley in formato JSON';
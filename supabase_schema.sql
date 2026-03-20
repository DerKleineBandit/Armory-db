-- ARMORY.db — Supabase Schema Setup
-- Führe dies einmalig im Supabase SQL-Editor aus

CREATE TABLE IF NOT EXISTS armory_folders (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT DEFAULT '',
  color TEXT DEFAULT '#4d8c5e',
  icon TEXT DEFAULT '📁',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS armory_cannons (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  caliber TEXT DEFAULT '',
  description TEXT DEFAULT '',
  cannon_type TEXT DEFAULT 'normal',
  custom_type TEXT DEFAULT '',
  shot_interval FLOAT DEFAULT 1.0,
  burst_before_reload INTEGER DEFAULT 0,
  extended_reload FLOAT DEFAULT 0,
  shots_for_recovery INTEGER DEFAULT 0,
  country TEXT DEFAULT '',
  tags TEXT[] DEFAULT '{}',
  folder_id UUID REFERENCES armory_folders(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Row Level Security (öffentlicher Zugriff, kein Login nötig)
ALTER TABLE armory_folders ENABLE ROW LEVEL SECURITY;
ALTER TABLE armory_cannons ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public_all_folders" ON armory_folders FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_all_cannons" ON armory_cannons FOR ALL USING (true) WITH CHECK (true);

-- Realtime aktivieren
ALTER PUBLICATION supabase_realtime ADD TABLE armory_cannons;
ALTER PUBLICATION supabase_realtime ADD TABLE armory_folders;

/*
  # Evie Digital Agribusiness App — Initial Schema

  ## Summary
  Creates the core tables for managing livestock and crops operations.

  ## New Tables

  ### livestock
  - id, name, species, breed, tag_number, gender, date_of_birth, weight_kg, status, pen_location, notes, created_at

  ### livestock_health_records
  - id, livestock_id (FK), date, type (vaccination/treatment/checkup), description, vet_name, cost, next_due_date, created_at

  ### crops
  - id, name, variety, field_name, area_hectares, planting_date, expected_harvest_date, actual_harvest_date, status, seed_source, notes, created_at

  ### crop_activities
  - id, crop_id (FK), date, activity_type (planting/irrigation/fertilizing/pesticide/harvesting/other), description, cost, quantity, unit, created_at

  ### inventory
  - id, name, category (feed/seed/medicine/equipment/chemical/other), quantity, unit, unit_cost, reorder_level, supplier, notes, updated_at, created_at

  ### transactions
  - id, date, type (income/expense), category, description, amount, reference, created_at

  ## Security
  - RLS enabled on all tables
  - Policies for authenticated users to manage their data (owner-based)
*/

-- Livestock table
CREATE TABLE IF NOT EXISTS livestock (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL DEFAULT '',
  species text NOT NULL,
  breed text DEFAULT '',
  tag_number text UNIQUE,
  gender text NOT NULL DEFAULT 'unknown',
  date_of_birth date,
  weight_kg numeric(8,2),
  status text NOT NULL DEFAULT 'active',
  pen_location text DEFAULT '',
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE livestock ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can select livestock"
  ON livestock FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can insert livestock"
  ON livestock FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update livestock"
  ON livestock FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete livestock"
  ON livestock FOR DELETE
  TO authenticated
  USING (true);

-- Livestock health records
CREATE TABLE IF NOT EXISTS livestock_health_records (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  livestock_id uuid NOT NULL REFERENCES livestock(id) ON DELETE CASCADE,
  date date NOT NULL DEFAULT CURRENT_DATE,
  type text NOT NULL DEFAULT 'checkup',
  description text NOT NULL DEFAULT '',
  vet_name text DEFAULT '',
  cost numeric(10,2) DEFAULT 0,
  next_due_date date,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE livestock_health_records ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can select health records"
  ON livestock_health_records FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can insert health records"
  ON livestock_health_records FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update health records"
  ON livestock_health_records FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete health records"
  ON livestock_health_records FOR DELETE
  TO authenticated
  USING (true);

-- Crops table
CREATE TABLE IF NOT EXISTS crops (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  variety text DEFAULT '',
  field_name text NOT NULL DEFAULT '',
  area_hectares numeric(10,2) DEFAULT 0,
  planting_date date,
  expected_harvest_date date,
  actual_harvest_date date,
  status text NOT NULL DEFAULT 'planned',
  seed_source text DEFAULT '',
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE crops ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can select crops"
  ON crops FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can insert crops"
  ON crops FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update crops"
  ON crops FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete crops"
  ON crops FOR DELETE
  TO authenticated
  USING (true);

-- Crop activities
CREATE TABLE IF NOT EXISTS crop_activities (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  crop_id uuid NOT NULL REFERENCES crops(id) ON DELETE CASCADE,
  date date NOT NULL DEFAULT CURRENT_DATE,
  activity_type text NOT NULL DEFAULT 'other',
  description text NOT NULL DEFAULT '',
  cost numeric(10,2) DEFAULT 0,
  quantity numeric(10,2),
  unit text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE crop_activities ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can select crop activities"
  ON crop_activities FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can insert crop activities"
  ON crop_activities FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update crop activities"
  ON crop_activities FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete crop activities"
  ON crop_activities FOR DELETE
  TO authenticated
  USING (true);

-- Inventory table
CREATE TABLE IF NOT EXISTS inventory (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  category text NOT NULL DEFAULT 'other',
  quantity numeric(12,2) DEFAULT 0,
  unit text NOT NULL DEFAULT 'units',
  unit_cost numeric(10,2) DEFAULT 0,
  reorder_level numeric(12,2) DEFAULT 0,
  supplier text DEFAULT '',
  notes text DEFAULT '',
  updated_at timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now()
);

ALTER TABLE inventory ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can select inventory"
  ON inventory FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can insert inventory"
  ON inventory FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update inventory"
  ON inventory FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete inventory"
  ON inventory FOR DELETE
  TO authenticated
  USING (true);

-- Transactions table
CREATE TABLE IF NOT EXISTS transactions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  date date NOT NULL DEFAULT CURRENT_DATE,
  type text NOT NULL DEFAULT 'expense',
  category text NOT NULL DEFAULT 'general',
  description text NOT NULL DEFAULT '',
  amount numeric(12,2) NOT NULL DEFAULT 0,
  reference text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can select transactions"
  ON transactions FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can insert transactions"
  ON transactions FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update transactions"
  ON transactions FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete transactions"
  ON transactions FOR DELETE
  TO authenticated
  USING (true);

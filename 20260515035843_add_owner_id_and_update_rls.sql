/*
  # Add user ownership to all tables

  ## Summary
  Adds an `owner_id` column to every data table so each farmer only sees their own records.
  Updates RLS policies to enforce ownership. Existing data is assigned to a placeholder (will be null for now).

  ## Changes
  - livestock: add owner_id (uuid, FK to auth.users)
  - livestock_health_records: add owner_id
  - crops: add owner_id
  - crop_activities: add owner_id
  - inventory: add owner_id
  - transactions: add owner_id
  - Drop existing permissive policies, replace with owner-based policies
  - Enable RLS on all tables (already enabled)
*/

-- Add owner_id to livestock
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'livestock' AND column_name = 'owner_id'
  ) THEN
    ALTER TABLE livestock ADD COLUMN owner_id uuid REFERENCES auth.users(id);
  END IF;
END $$;

-- Add owner_id to livestock_health_records
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'livestock_health_records' AND column_name = 'owner_id'
  ) THEN
    ALTER TABLE livestock_health_records ADD COLUMN owner_id uuid REFERENCES auth.users(id);
  END IF;
END $$;

-- Add owner_id to crops
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'crops' AND column_name = 'owner_id'
  ) THEN
    ALTER TABLE crops ADD COLUMN owner_id uuid REFERENCES auth.users(id);
  END IF;
END $$;

-- Add owner_id to crop_activities
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'crop_activities' AND column_name = 'owner_id'
  ) THEN
    ALTER TABLE crop_activities ADD COLUMN owner_id uuid REFERENCES auth.users(id);
  END IF;
END $$;

-- Add owner_id to inventory
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'inventory' AND column_name = 'owner_id'
  ) THEN
    ALTER TABLE inventory ADD COLUMN owner_id uuid REFERENCES auth.users(id);
  END IF;
END $$;

-- Add owner_id to transactions
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'transactions' AND column_name = 'owner_id'
  ) THEN
    ALTER TABLE transactions ADD COLUMN owner_id uuid REFERENCES auth.users(id);
  END IF;
END $$;

-- Drop old permissive policies and replace with owner-based ones

-- LIVESTOCK
DROP POLICY IF EXISTS "Authenticated users can select livestock" ON livestock;
DROP POLICY IF EXISTS "Authenticated users can insert livestock" ON livestock;
DROP POLICY IF EXISTS "Authenticated users can update livestock" ON livestock;
DROP POLICY IF EXISTS "Authenticated users can delete livestock" ON livestock;

CREATE POLICY "Owners can view own livestock"
  ON livestock FOR SELECT
  TO authenticated
  USING (auth.uid() = owner_id);

CREATE POLICY "Owners can insert own livestock"
  ON livestock FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can update own livestock"
  ON livestock FOR UPDATE
  TO authenticated
  USING (auth.uid() = owner_id)
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can delete own livestock"
  ON livestock FOR DELETE
  TO authenticated
  USING (auth.uid() = owner_id);

-- LIVESTOCK HEALTH RECORDS
DROP POLICY IF EXISTS "Authenticated users can select health records" ON livestock_health_records;
DROP POLICY IF EXISTS "Authenticated users can insert health records" ON livestock_health_records;
DROP POLICY IF EXISTS "Authenticated users can update health records" ON livestock_health_records;
DROP POLICY IF EXISTS "Authenticated users can delete health records" ON livestock_health_records;

CREATE POLICY "Owners can view own health records"
  ON livestock_health_records FOR SELECT
  TO authenticated
  USING (auth.uid() = owner_id);

CREATE POLICY "Owners can insert own health records"
  ON livestock_health_records FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can update own health records"
  ON livestock_health_records FOR UPDATE
  TO authenticated
  USING (auth.uid() = owner_id)
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can delete own health records"
  ON livestock_health_records FOR DELETE
  TO authenticated
  USING (auth.uid() = owner_id);

-- CROPS
DROP POLICY IF EXISTS "Authenticated users can select crops" ON crops;
DROP POLICY IF EXISTS "Authenticated users can insert crops" ON crops;
DROP POLICY IF EXISTS "Authenticated users can update crops" ON crops;
DROP POLICY IF EXISTS "Authenticated users can delete crops" ON crops;

CREATE POLICY "Owners can view own crops"
  ON crops FOR SELECT
  TO authenticated
  USING (auth.uid() = owner_id);

CREATE POLICY "Owners can insert own crops"
  ON crops FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can update own crops"
  ON crops FOR UPDATE
  TO authenticated
  USING (auth.uid() = owner_id)
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can delete own crops"
  ON crops FOR DELETE
  TO authenticated
  USING (auth.uid() = owner_id);

-- CROP ACTIVITIES
DROP POLICY IF EXISTS "Authenticated users can select crop activities" ON crop_activities;
DROP POLICY IF EXISTS "Authenticated users can insert crop activities" ON crop_activities;
DROP POLICY IF EXISTS "Authenticated users can update crop activities" ON crop_activities;
DROP POLICY IF EXISTS "Authenticated users can delete crop activities" ON crop_activities;

CREATE POLICY "Owners can view own crop activities"
  ON crop_activities FOR SELECT
  TO authenticated
  USING (auth.uid() = owner_id);

CREATE POLICY "Owners can insert own crop activities"
  ON crop_activities FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can update own crop activities"
  ON crop_activities FOR UPDATE
  TO authenticated
  USING (auth.uid() = owner_id)
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can delete own crop activities"
  ON crop_activities FOR DELETE
  TO authenticated
  USING (auth.uid() = owner_id);

-- INVENTORY
DROP POLICY IF EXISTS "Authenticated users can select inventory" ON inventory;
DROP POLICY IF EXISTS "Authenticated users can insert inventory" ON inventory;
DROP POLICY IF EXISTS "Authenticated users can update inventory" ON inventory;
DROP POLICY IF EXISTS "Authenticated users can delete inventory" ON inventory;

CREATE POLICY "Owners can view own inventory"
  ON inventory FOR SELECT
  TO authenticated
  USING (auth.uid() = owner_id);

CREATE POLICY "Owners can insert own inventory"
  ON inventory FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can update own inventory"
  ON inventory FOR UPDATE
  TO authenticated
  USING (auth.uid() = owner_id)
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can delete own inventory"
  ON inventory FOR DELETE
  TO authenticated
  USING (auth.uid() = owner_id);

-- TRANSACTIONS
DROP POLICY IF EXISTS "Authenticated users can select transactions" ON transactions;
DROP POLICY IF EXISTS "Authenticated users can insert transactions" ON transactions;
DROP POLICY IF EXISTS "Authenticated users can update transactions" ON transactions;
DROP POLICY IF EXISTS "Authenticated users can delete transactions" ON transactions;

CREATE POLICY "Owners can view own transactions"
  ON transactions FOR SELECT
  TO authenticated
  USING (auth.uid() = owner_id);

CREATE POLICY "Owners can insert own transactions"
  ON transactions FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can update own transactions"
  ON transactions FOR UPDATE
  TO authenticated
  USING (auth.uid() = owner_id)
  WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can delete own transactions"
  ON transactions FOR DELETE
  TO authenticated
  USING (auth.uid() = owner_id);

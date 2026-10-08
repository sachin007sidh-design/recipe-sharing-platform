-- Phase B migration: run ONCE on your existing recipe_db
-- mysql -u root -p recipe_db < database/migration_phase_b.sql
USE recipe_db;

ALTER TABLE recipes
    ADD COLUMN prep_time  INT NOT NULL DEFAULT 30,
    ADD COLUMN servings   INT NOT NULL DEFAULT 2,
    ADD COLUMN difficulty ENUM('EASY','MEDIUM','HARD') NOT NULL DEFAULT 'EASY';

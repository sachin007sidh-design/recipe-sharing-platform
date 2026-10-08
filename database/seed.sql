-- Sample data: 4 demo cooks + 12 approved recipes with Unsplash photos.
-- Safe to run more than once (removes the old sample rows first).
-- Run AFTER migration_phase_b.sql:   mysql -u root -p recipe_db < database/seed.sql
-- Demo logins: priya@example.com / arjun@example.com / sneha@example.com / rohan@example.com
-- Password for all demo users: password123
USE recipe_db;

INSERT IGNORE INTO users (name, email, password_hash, role) VALUES
('Priya Sharma', 'priya@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'USER'),
('Arjun Mehta',  'arjun@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'USER'),
('Sneha Kapoor', 'sneha@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'USER'),
('Rohan Gupta',  'rohan@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'USER');

-- Remove previously seeded recipes so this script can be re-run
DELETE FROM recipes WHERE user_id IN (SELECT id FROM users WHERE email LIKE '%@example.com');

INSERT INTO recipes (user_id, title, description, ingredients, instructions, category, image_path, prep_time, servings, difficulty, status) VALUES

((SELECT id FROM users WHERE email='priya@example.com'),
 'Fluffy Blueberry Pancakes',
 'Soft, golden pancakes studded with juicy blueberries. A weekend breakfast favourite.',
 '1 1/2 cups all-purpose flour
2 tbsp sugar
1 tbsp baking powder
1/2 tsp salt
1 1/4 cups milk
1 egg
3 tbsp melted butter
1 cup blueberries',
 '1. Whisk the flour, sugar, baking powder and salt in a large bowl.
2. Mix the milk, egg and melted butter, then pour into the dry ingredients and stir until just combined.
3. Fold in the blueberries.
4. Heat a lightly greased pan over medium heat and pour in 1/4 cup of batter per pancake.
5. Cook until bubbles form, flip, and cook until golden. Serve warm with maple syrup.',
 'Breakfast', 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?auto=format&fit=crop&w=800&q=80', 25, 4, 'EASY', 'APPROVED'),

((SELECT id FROM users WHERE email='sneha@example.com'),
 'Avocado Egg Toast',
 'Creamy smashed avocado and a perfectly runny egg on crunchy sourdough.',
 '2 slices sourdough bread
1 ripe avocado
2 eggs
1 tsp lemon juice
Chilli flakes
Salt and pepper',
 '1. Toast the bread until golden and crisp.
2. Mash the avocado with lemon juice, salt and pepper.
3. Fry or poach the eggs to your liking.
4. Spread the avocado on the toast, top with the eggs and sprinkle with chilli flakes.',
 'Snacks', 'https://images.unsplash.com/photo-1525351484163-7529414344d8?auto=format&fit=crop&w=800&q=80', 10, 2, 'EASY', 'APPROVED'),

((SELECT id FROM users WHERE email='arjun@example.com'),
 'Berry Blast Smoothie',
 'A thick, chilled berry smoothie that is ready in five minutes.',
 '1 cup mixed berries (frozen works well)
1 ripe banana
1 cup plain yogurt
1/2 cup milk
1 tbsp honey
A few ice cubes',
 '1. Add everything to a blender.
2. Blend on high until completely smooth.
3. Taste and add more honey if you like it sweeter.
4. Pour into glasses and serve immediately.',
 'Beverages', 'https://images.unsplash.com/photo-1590301157890-4810ed352733?auto=format&fit=crop&w=800&q=80', 5, 2, 'EASY', 'APPROVED'),

((SELECT id FROM users WHERE email='rohan@example.com'),
 'Classic Margherita Pizza',
 'Crisp crust, tangy tomato sauce, melting mozzarella and fresh basil.',
 '500 g pizza dough
1 cup tomato sauce
200 g fresh mozzarella, sliced
Fresh basil leaves
2 tbsp olive oil
Salt',
 '1. Preheat the oven to its highest setting (about 250 C) with a baking tray inside.
2. Stretch the dough into a round on floured baking paper.
3. Spread the tomato sauce, leaving a small border, and add the mozzarella.
4. Slide onto the hot tray and bake for 10 to 12 minutes until the crust is golden.
5. Top with basil and a drizzle of olive oil.',
 'Dinner', 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?auto=format&fit=crop&w=800&q=80', 60, 4, 'MEDIUM', 'APPROVED'),

((SELECT id FROM users WHERE email='priya@example.com'),
 'Creamy Tomato Pasta',
 'Penne in a silky tomato and cream sauce, ready in half an hour.',
 '250 g penne
2 tbsp olive oil
3 garlic cloves, minced
400 g crushed tomatoes
1/2 cup cream
1 tsp sugar
Fresh basil
Grated cheese
Salt and pepper',
 '1. Boil the pasta in salted water until al dente, then drain.
2. Saute the garlic in olive oil for one minute.
3. Add the tomatoes, sugar, salt and pepper and simmer for 10 minutes.
4. Stir in the cream and cook for 2 more minutes.
5. Toss the pasta in the sauce and finish with basil and cheese.',
 'Dinner', 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=800&q=80', 30, 3, 'EASY', 'APPROVED'),

((SELECT id FROM users WHERE email='arjun@example.com'),
 'Lemon Herb Grilled Salmon',
 'Flaky salmon with a bright lemon, garlic and herb marinade.',
 '2 salmon fillets
2 tbsp olive oil
1 lemon (juice and slices)
2 garlic cloves, minced
1 tsp dried oregano
Chopped parsley
Salt and pepper',
 '1. Mix olive oil, lemon juice, garlic, oregano, salt and pepper.
2. Coat the salmon and marinate for 15 minutes.
3. Grill or pan-sear over medium-high heat, 4 to 5 minutes per side.
4. Serve topped with parsley and lemon slices.',
 'Dinner', 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=800&q=80', 35, 2, 'MEDIUM', 'APPROVED'),

((SELECT id FROM users WHERE email='rohan@example.com'),
 'Juicy Cheeseburger',
 'Thick home-made patties, melted cheese and all the toppings.',
 '500 g ground beef
4 burger buns
4 cheese slices
Lettuce
1 tomato, sliced
1 onion, sliced
Pickles
Salt and pepper
Ketchup and mustard',
 '1. Divide the beef into 4 portions, shape into patties and season well.
2. Cook on a hot pan or grill for 3 to 4 minutes per side.
3. Add the cheese in the last minute so it melts.
4. Toast the buns lightly.
5. Assemble with the toppings and sauces and serve right away.',
 'Lunch', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80', 40, 4, 'MEDIUM', 'APPROVED'),

((SELECT id FROM users WHERE email='sneha@example.com'),
 'Hearty Tomato Soup',
 'Slow-simmered tomato soup with a touch of cream. Perfect with toast.',
 '1 kg ripe tomatoes, chopped
1 onion, chopped
3 garlic cloves
2 tbsp butter
2 cups vegetable stock
1/4 cup cream
Fresh basil
Salt and pepper',
 '1. Melt the butter and cook the onion and garlic until soft.
2. Add the tomatoes and cook for 10 minutes.
3. Pour in the stock and simmer for 20 minutes.
4. Blend until smooth, stir in the cream and season to taste.
5. Serve hot with basil on top.',
 'Lunch', 'https://images.unsplash.com/photo-1547592166-23ac45744acd?auto=format&fit=crop&w=800&q=80', 40, 4, 'EASY', 'APPROVED'),

((SELECT id FROM users WHERE email='priya@example.com'),
 'Rainbow Garden Salad Bowl',
 'A colourful, filling vegan bowl with chickpeas and a lemon tahini dressing.',
 '2 cups mixed greens
1 cup cooked chickpeas
1 cucumber, sliced
1 carrot, grated
1 cup cherry tomatoes
1/2 avocado
Dressing: 2 tbsp tahini, 2 tbsp lemon juice, 2 tbsp water, pinch of salt',
 '1. Whisk the dressing ingredients until smooth and pourable.
2. Arrange the greens, chickpeas and vegetables in a bowl.
3. Top with sliced avocado.
4. Drizzle with the dressing and serve.',
 'Vegan', 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=800&q=80', 15, 2, 'EASY', 'APPROVED'),

((SELECT id FROM users WHERE email='arjun@example.com'),
 'Colourful Veggie Stir Fry',
 'Crunchy vegetables in a savoury soy and ginger sauce, done in 20 minutes.',
 '2 cups broccoli florets
1 bell pepper, sliced
1 carrot, sliced
1 cup snap peas
3 tbsp soy sauce
1 tbsp sesame oil
2 garlic cloves, minced
1 tsp grated ginger
Cooked rice to serve',
 '1. Heat the sesame oil in a wok over high heat.
2. Stir-fry the garlic and ginger for 30 seconds.
3. Add the carrot and broccoli and cook for 3 minutes.
4. Add the pepper and snap peas and cook for 2 more minutes.
5. Pour in the soy sauce, toss well and serve over rice.',
 'Vegan', 'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=800&q=80', 20, 3, 'EASY', 'APPROVED'),

((SELECT id FROM users WHERE email='sneha@example.com'),
 'Molten Chocolate Lava Cake',
 'A rich chocolate cake with a warm, gooey centre. Impressive and surprisingly quick.',
 '150 g dark chocolate
100 g butter
2 eggs plus 2 egg yolks
1/4 cup sugar
2 tbsp flour
Cocoa powder for dusting',
 '1. Preheat the oven to 200 C and grease 4 ramekins with butter and cocoa.
2. Melt the chocolate and butter together and let cool slightly.
3. Whisk the eggs, yolks and sugar until pale, then fold in the chocolate and flour.
4. Divide the batter between the ramekins and bake for 10 to 12 minutes.
5. Rest for 1 minute, invert onto plates and serve immediately.',
 'Dessert', 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=800&q=80', 35, 4, 'HARD', 'APPROVED'),

((SELECT id FROM users WHERE email='rohan@example.com'),
 'Vanilla Ice Cream Sundae',
 'Classic sundae with chocolate sauce, whipped cream, nuts and a cherry on top.',
 '4 scoops vanilla ice cream
1/4 cup chocolate sauce
Whipped cream
2 tbsp crushed nuts
2 cherries',
 '1. Scoop the ice cream into two chilled glasses.
2. Pour over the chocolate sauce.
3. Add whipped cream and sprinkle with nuts.
4. Finish with a cherry on top and serve at once.',
 'Dessert', 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?auto=format&fit=crop&w=800&q=80', 10, 2, 'EASY', 'APPROVED');

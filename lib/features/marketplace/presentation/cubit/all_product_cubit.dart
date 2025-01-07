import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductCubit extends Cubit<List<ProductItem>> {
  AllProductCubit()
      : super(
          [
            ProductItem(
              id: 'beef-bone',
              label: 'Beef Bond',
              tags: ['beef-bone', 'beef', 'beef-another'],
            ),
            ProductItem(
              id: 'beef-brisket',
              label: 'Beef Brisket',
              tags: ['beef-brisket', 'beef', 'beef-another'],
            ),
            ProductItem(
              id: 'beef-flank',
              label: 'Beef Flank',
              tags: ['beef-flank', 'beef', 'beef-another'],
            ),
            ProductItem(
              id: 'beef-steak',
              label: 'Beef Steak',
              tags: ['beef-steak', 'beef', 'beef-another'],
            ),
            ProductItem(
              id: 'beef-chuck',
              label: 'Beef Chuck',
              image: 'assets/images/cate-detail/cate-beef/beef-chuck.png',
              tags: ['beef-chuck', 'beef'],
            ),
            ProductItem(
              id: 'beef-diced',
              label: 'Beef Diced',
              tags: ['beef-diced', 'beef', 'beef-another'],
            ),
            ProductItem(
              id: 'beef-ground',
              label: 'Beef Ground',
              image: 'assets/images/cate-detail/cate-beef/beef-ground.png',
              tags: ['beef-ground', 'beef'],
            ),
            ProductItem(
              id: 'beef-plate',
              label: 'Beef Plate',
              image: 'assets/images/cate-detail/cate-beef/beef-shortplate.png',
              tags: ['beef-plate', 'beef'],
            ),
            ProductItem(
              id: 'beef-rib',
              label: 'Beef Rib',
              image: 'assets/images/cate-detail/cate-beef/beef-rib.png',
              tags: ['beef-rib', 'beef'],
            ),
            ProductItem(
              id: 'beef-shabu-shabu',
              label: 'Beef Shabu Shabu',
              tags: ['beef-shabu-shabu', 'beef', 'beef-another'],
            ),
            ProductItem(
              id: 'beef-tbone',
              label: 'Beef Tbone',
              image: 'assets/images/cate-detail/cate-beef/beef-tbone.png',
              tags: ['beef-tbone', 'beef'],
            ),
            ProductItem(
              id: 'beef-tenderloin',
              label: 'Beef Tenderloin',
              image: 'assets/images/cate-detail/cate-beef/beef-tenderloin.png',
              tags: ['beef-tenderloin', 'beef'],
            ),

            ///
            ProductItem(
              id: 'chicken-bone',
              label: 'Chicken Bone',
              tags: ['chicken-bone', 'chicken', 'chicken-another'],
            ),
            ProductItem(
              id: 'chicken-breast',
              label: 'Chicken Breast',
              image: 'assets/images/cate-detail/cate-chicken/chicken-breast.png',
              tags: ['chicken-breast', 'chicken'],
            ),
            ProductItem(
              id: 'chicken-drumstick',
              label: 'Chicken Drumstick',
              image: 'assets/images/cate-detail/cate-chicken/chicken-drumstick.png',
              tags: ['chicken-drumstick', 'chicken'],
            ),
            ProductItem(
              id: 'chicken-ground',
              label: 'Chicken Ground',
              tags: ['chicken-ground', 'chicken', 'chicken-another'],
            ),
            ProductItem(
              id: 'chicken-thigh',
              label: 'Chicken Thign',
              tags: ['chicken-thigh', 'chicken', 'chicken-another'],
            ),
            ProductItem(
              id: 'chicken-whole',
              label: 'Whole Chicken',
              tags: ['chicken-whole', 'chicken', 'chicken-another'],
            ),
            ProductItem(
              id: 'chicken-wing',
              label: 'Chicken Wings',
              image: 'assets/images/cate-detail/cate-chicken/chicken-wing.png',
              tags: ['chicken-wing', 'chicken'],
            ),

            ///
            ProductItem(
              id: 'corn-flour',
              label: 'Corn Flour',
              image: 'assets/images/cate-detail/cate-powder/powder-flour.png',
              tags: ['corn-flour', 'flour', 'dry'],
            ),
            ProductItem(
              id: 'baking-powder',
              label: 'Baking Powder',
              image: 'assets/images/cate-detail/cate-powder/powder-baking-soda.png',
              tags: ['baking-powder', 'flour', 'dry'],
            ),
            ProductItem(
              id: 'flour-wheat',
              label: 'Wheat Flour',
              image: 'assets/images/cate-detail/cate-powder/powder-flour.png',
              tags: ['flour-wheat', 'flour', 'dry'],
            ),
            ProductItem(
              id: 'bicarbonate-of-soda',
              label: 'Bicarbonate Soda',
              image: 'assets/images/cate-detail/cate-powder/powder-baking-soda.png',
              tags: ['bicarbonate-of-soda', 'flour', 'dry'],
            ),
            ProductItem(
              id: 'plain-flour',
              label: 'Plain Flour',
              image: 'assets/images/cate-detail/cate-powder/powder-flour.png',
              tags: ['plain-flour', 'flour', 'dry'],
            ),
            ProductItem(
              id: 'self-raising-flour',
              label: 'Self Raising Flour',
              image: 'assets/images/cate-detail/cate-powder/powder-flour.png',
              tags: ['self-raising-flour', 'flour', 'dry'],
            ),
            ProductItem(
              id: 'rice',
              label: 'Rice',
              image: 'assets/images/cate-detail/cate-powder/powder-rice.png',
              tags: ['rice', 'dry'],
            ),

            ///* Eggs
            ProductItem(
              id: 'egg-chicken',
              label: 'Chicken Egg',
              image: 'assets/images/cate-detail/cate-egg/egg-chicken.png',
              tags: ['egg-chicken', 'egg', 'chicken'],
            ),
            ProductItem(
              id: 'egg-duck',
              label: 'Duck Egg',
              image: 'assets/images/cate-detail/cate-egg/egg-duck.png',
              tags: ['egg-duck', 'egg', 'duck'],
            ),
            ProductItem(
              id: 'egg-quail',
              label: 'Quail Egg',
              image: 'assets/images/cate-detail/cate-egg/egg-quail.png',
              tags: ['egg-quail', 'egg', 'quail'],
            ),

            ///* Enoki
            ProductItem(
              id: 'enoki',
              label: 'Enoki',
              image: 'assets/images/cate-detail/cate-mushroom/nam-enoki-mushroom.png',
              tags: ['enoki', 'mushroom'],
            ),
            ProductItem(
              id: 'mushroom',
              label: 'Mushroom',
              image: 'assets/images/cate-detail/cate-mushroom/nam-mushroom.png',
              tags: ['mushroom'],
            ),

            ///* Fish
            ProductItem(
              id: 'salmon',
              label: 'Salmon',
              image: 'assets/images/cate-detail/cate-fish/fish-salmon.png',
              tags: ['salmon', 'fish', 'seafood'],
            ),
            ProductItem(
              id: 'talipia',
              label: 'Talipia',
              image: 'assets/images/cate-detail/cate-fish/fish-tilapia.png',
              tags: ['talipia', 'fish', 'seafood'],
            ),
            ProductItem(
              id: 'tuna',
              label: 'Tuna',
              image: 'assets/images/cate-detail/cate-fish/fish-tuna.png',
              tags: ['tuna', 'fish', 'seafood'],
            ),

            ///* Fruit
            ProductItem(
              id: 'blackberries',
              label: 'Blackberries',
              tags: ['berry', 'fruit', 'blackberries'],
            ),
            ProductItem(
              id: 'blueberries',
              label: 'Blueberries',
              tags: ['berry', 'fruit', 'blueberries'],
            ),
            ProductItem(
              id: 'strawberries',
              label: 'Strawberries',
              image: 'assets/images/cate-detail/cate-fruit/fruit-berry.png',
              tags: ['berry', 'fruit', 'strawberries'],
            ),
            ProductItem(
              id: 'grapes',
              label: 'Grapes',
              tags: ['berry', 'fruit', 'grapes'],
            ),

            ProductItem(
              id: 'avocado',
              label: 'Avocado',
              tags: ['drupe', 'fruit', 'avocado'],
            ),
            ProductItem(
              id: 'mango',
              label: 'Mango',
              image: 'assets/images/cate-detail/cate-fruit/fruit-tropical.png',
              tags: ['drupe', 'fruit', 'mango', 'tropical'],
            ),
            ProductItem(
              id: 'peach',
              label: 'Peach',
              tags: ['drupe', 'fruit', 'peach'],
            ),

            ProductItem(
              id: 'grapefruit',
              label: 'Grapefruit',
              tags: ['hesperidium', 'fruit', 'grapefruit'],
            ),
            ProductItem(
              id: 'lemon',
              label: 'Lemon',
              tags: ['hesperidium', 'fruit', 'lemon'],
            ),
            ProductItem(
              id: 'lime',
              label: 'Lime',
              tags: ['hesperidium', 'fruit', 'lime'],
            ),
            ProductItem(
              id: 'orange',
              label: 'Orange',
              image: 'assets/images/cate-detail/cate-fruit/fruit-hesperidium.png',
              tags: ['hesperidium', 'fruit', 'orange'],
            ),
            ProductItem(
              id: 'tangerine',
              label: 'Tangerine',
              tags: ['hesperidium', 'fruit', 'tangerine'],
            ),

            ProductItem(
              id: 'apple',
              label: 'Apple',
              image: 'assets/images/cate-detail/cate-fruit/fruit-pome.png',
              tags: ['pome', 'fruit', 'apple'],
            ),
            ProductItem(
              id: 'pear',
              label: 'Pear',
              tags: ['pome', 'fruit', 'pear'],
            ),

            ProductItem(
              id: 'banana',
              label: 'Banana',
              tags: ['repo', 'fruit', 'banana'],
            ),
            ProductItem(
              id: 'coconut',
              label: 'Coconut',
              tags: ['repo', 'fruit', 'coconut'],
            ),
            ProductItem(
              id: 'corn',
              label: 'Corn',
              tags: ['repo', 'fruit', 'corn'],
            ),
            ProductItem(
              id: 'cucumber',
              label: 'Cucumber',
              tags: ['repo', 'fruit', 'cucumber'],
            ),
            ProductItem(
              id: 'melon',
              label: 'Melon',
              tags: ['repo', 'fruit', 'melon'],
            ),
            ProductItem(
              id: 'pineapple',
              label: 'Pineapple',
              tags: ['repo', 'fruit', 'pineapple'],
            ),
            ProductItem(
              id: 'pumpkin',
              label: 'Pumpkin',
              tags: ['repo', 'fruit', 'pumpkin'],
            ),
            ProductItem(
              id: 'sapodilla',
              label: 'Sapodilla',
              tags: ['repo', 'fruit', 'sapodilla'],
            ),
            ProductItem(
              id: 'watermelon',
              label: 'Watermelon',
              image: 'assets/images/cate-detail/cate-fruit/fruit-pepo.png',
              tags: ['repo', 'fruit', 'watermelon'],
            ),

            ///*
            ProductItem(
              id: 'pork-rips-bone-in',
              label: 'Pork Rips Bone In',
              tags: ['another', 'pork-rips-bone-in', 'pork'],
            ),
            ProductItem(
              id: 'pork-rips-boneless',
              label: 'Pork Rips Boneless',
              tags: ['another', 'pork-rips-boneless', 'pork'],
            ),
            ProductItem(
              id: 'pork-stew',
              label: 'Pork Stew',
              tags: ['another', 'pork-stew', 'pork'],
            ),
            ProductItem(
              id: 'pork-tray',
              label: 'Pork Tray',
              tags: ['another', 'pork-tray', 'pork'],
            ),
            ProductItem(
              id: 'pork-tray-bone-in',
              label: 'Pork Tray Bone In',
              tags: ['another', 'pork-tray-bone-in', 'pork'],
            ),

            ProductItem(
              id: 'pork-belly',
              label: 'Pork Belly',
              image: 'assets/images/cate-detail/cate-pork/pork-belly.png',
              tags: ['pork-belly', 'pork'],
            ),

            ProductItem(
              id: 'pork-ground',
              label: 'Pork Ground',
              image: 'assets/images/cate-detail/cate-pork/pork-ground.png',
              tags: ['pork-ground', 'pork'],
            ),

            ProductItem(
              id: 'pork-ham',
              label: 'Pork Ham',
              image: 'assets/images/cate-detail/cate-pork/pork-ham.png',
              tags: ['pork-ham', 'pork'],
            ),

            ProductItem(
              id: 'pork-lean',
              label: 'Pork Lean',
              image: 'assets/images/cate-detail/cate-pork/pork-lean.png',
              tags: ['pork-lean', 'pork'],
            ),

            ///* Seafood
            ProductItem(
              id: 'clam',
              label: 'Clam',
              image: 'assets/images/cate-detail/cate-seafood/sea-clam.png',
              tags: ['clam', 'seafood'],
            ),
            ProductItem(
              id: 'octopus',
              label: 'Octopus',
              image: 'assets/images/cate-detail/cate-seafood/sea-octopus.png',
              tags: ['octopus', 'seafood'],
            ),
            ProductItem(
              id: 'shrimp',
              label: 'Shrimp',
              image: 'assets/images/cate-detail/cate-seafood/sea-shrimp.png',
              tags: ['shrimp', 'seafood'],
            ),
            ProductItem(
              id: 'crab',
              label: 'Crab',
              tags: ['crab', 'seafood'],
            ),
            ProductItem(
              id: 'squid',
              label: 'Squid',
              image: 'assets/images/cate-detail/cate-seafood/sea-squid.png',
              tags: ['squid', 'seafood'],
            ),

            ///* Seasoning
            ProductItem(
              id: 'all-purpose',
              label: 'All Purpose',
              tags: ['all-purpose', 'seasoning'],
            ),
            ProductItem(
              id: 'paprika',
              label: 'Paprika',
              tags: ['paprika', 'seasoning'],
            ),
            ProductItem(
              id: 'beef-broth',
              label: 'Beef Broth',
              tags: ['beef-broth', 'seasoning'],
            ),
            ProductItem(
              id: 'black-pepper',
              label: 'Black Pepper',
              image: 'assets/images/cate-detail/cate-seasoning/ssn-hot.png',
              tags: ['black-pepper', 'seasoning'],
            ),
            ProductItem(
              id: 'salt',
              label: 'Salt',
              image: 'assets/images/cate-detail/cate-seasoning/ssn-saline.png',
              tags: ['salt', 'seasoning'],
            ),
            ProductItem(
              id: 'sugar',
              label: 'Sugar',
              image: 'assets/images/cate-detail/cate-seasoning/ssn-saccharine.png',
              tags: ['sugar', 'seasoning'],
            ),
            ProductItem(
              id: 'cooking-oil',
              label: 'Cooking Oil',
              image: 'assets/images/cate-detail/cate-seasoning/ssn-oil.png',
              tags: ['cooking-oil', 'seasoning'],
            ),

            ///* Vegetable
            ProductItem(
              id: 'bean',
              label: 'Bean',
              tags: ['vegetable', 'bean'],
            ),

            ProductItem(
              id: 'spinach',
              label: 'Spinach',
              tags: ['vegetable', 'vegetable-dark-green', 'spinach'],
            ),

            ProductItem(
              id: 'broccoli',
              label: 'Broccoli',
              tags: ['vegetable', 'vegetable-dark-green', 'broccoli'],
            ),

            ProductItem(
              id: 'lettuce',
              label: 'Lettuce',
              tags: ['vegetable', 'vegetable-dark-green', 'lettuce'],
            ),

            ProductItem(
              id: 'bell-pepper',
              label: 'Bell Pepper',
              tags: ['vegetable', 'vegetable-red-orange', 'bell-pepper'],
            ),

            ProductItem(
              id: 'carrot',
              label: 'Carrot',
              tags: ['vegetable', 'vegetable-red-orange', 'carrot'],
            ),

            ProductItem(
              id: 'sweet-potato',
              label: 'Sweet Potato',
              tags: ['vegetable', 'vegetable-red-orange', 'sweet-potato'],
            ),

            ProductItem(
              id: 'potato',
              label: 'Potato',
              tags: ['vegetable', 'vegetable-starchy', 'potato'],
            ),

            ProductItem(
              id: 'tomato',
              label: 'Tomato',
              tags: ['vegetable', 'vegetable-red-orange', 'tomato'],
            ),

            ProductItem(
              id: 'onion',
              label: 'Onion',
              tags: ['vegetable', 'onion'],
            ),
          ],
        );

  ProductItem getProduct(String id) {
    return state.firstWhere((element) => element.id == id);
  }
}

class ProductItem {
  final String id;
  final String label;
  final String? image;
  final List<String> tags;

  ProductItem({
    required this.id,
    required this.label,
    required this.tags,
    this.image,
  });
}

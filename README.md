# BSWearOnlineShop
Упрощенный вариант клиент-серверного приложения. 
ТЗ:
#### Экран списка категорий
Данные (категории и подкатегории) загружаются из http://blackstarshop.ru/index.php?route=api/v1/categories
Нужно показать загруженные категории, по нажатию переходить на экран подкатегорий
#### Экран подкатегорий
Нужно показать подкатегории выбранной категории. По нажатию переходить на экран списка товаров
#### Экран списка товаров
Данные (товары) загружаются из http://blackstarshop.ru/index.php?route=api/v1/products&cat_id={id категории}
Нужно показать картинку, название и стоимость товаров. По нажатию переходить в карточку товара
#### Карточка товара
Нужно показать галлерею фото товара, название, цену, описание, выбор цвета и размера (доступны разные размеры в зависимости от выбранного цвета)
#### Товар (с выбранным цветом и размером) можно положить в корзину (товары в корзине кэшируются) С этого экрана можно перейти на экран корзины
#### Экран корзины
Показывается список добавленных товаров (название, цена, картинка, цвет, размер) Товары из корзины можно удалить

| 1             |  2          | 3          |
:-------------------------:|:-------------------------:|:-------------------------:
![1](https://user-images.githubusercontent.com/73439070/109568597-31263e00-7af8-11eb-899c-2cd15cb8f320.png) | ![2](https://user-images.githubusercontent.com/73439070/109568622-3b483c80-7af8-11eb-8154-0bc3e416181b.png) | ![3](https://user-images.githubusercontent.com/73439070/109568641-426f4a80-7af8-11eb-8b86-007a0ccf249e.png)
| 4             |  5          | 6          |
:-------------------------:|:-------------------------:|:-------------------------:
![4](https://user-images.githubusercontent.com/73439070/109568748-6763bd80-7af8-11eb-8098-4b79ead8af66.png) | ![5](https://user-images.githubusercontent.com/73439070/109568775-70548f00-7af8-11eb-9061-df8c007a38b4.png) | ![6](https://user-images.githubusercontent.com/73439070/109568819-819d9b80-7af8-11eb-828a-ae640f6c401a.png)




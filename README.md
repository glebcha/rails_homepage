### Бложик и немного интересного     

Что есть "из коробки":

* Админка на основе rails_admin

* Переменные окружения с помощью figaro

* Человекопонятные URL (stringex)

* Bootstrap 3

* Реализованы роли пользователей с возможностью гибкой настройки уровней доступа (проще посмотреть ability.rb)

* Авторизация с помощью Github (простая регистрация выпилена, работает только для гитхаба)

* Теги (похожие записи, облако тегов, записи по тегу)

* Пагинация для списка записей (kaminari)

* Навигация на странице записи (предыдущая/следующая запись)

* Отображение количества просмотров и отображение популярных записей по количеству хитов (punching_bag)

* Статусы записи - черновик, опубликована, забанена (по-умолчанию отображаются только опубликованные записи, роль user создает записи только со статусом "черновик") 

* Отображение последних застаренных репозиториев на гитхабе (octokit + faraday для кэширования)

* Отображение последней фотографии из ленты инстаграма

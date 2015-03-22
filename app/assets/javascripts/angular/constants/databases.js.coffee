angular
  .module('app.railsbox')
  .constant 'DATABASES', [
      { id: 'postgresql', name: I18n.t('boxes.form.postgresql') },
      { id: 'mysql',      name: I18n.t('boxes.form.mysql') },
      { id: 'mongodb',    name: I18n.t('boxes.form.mongodb') },
      { id: 'redis',      name: I18n.t('boxes.form.redis') },
    ]

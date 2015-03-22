angular
  .module('app.railsbox')
  .constant 'BACKGROUND_JOBS', [
      { id: 'delayed_job', name: 'delayed_job' },
      { id: 'sidekiq',     name: 'sidekiq' },
      { id: 'resque',      name: 'resque' },
    ]

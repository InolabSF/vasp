desc 'This task is called by the Heroku scheduler add-on'

task :square_data_collection => :environment do
  Tasks::SquareDataCollectionTask.collect_all
end

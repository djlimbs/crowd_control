namespace :db do
  desc "Annotates our models with the db schema"
  task :annotate do
    `bundle exec annotate --position=before`
  end
end

Rake::Task["db:migrate"].enhance do
  Rake::Task["db:annotate"].invoke
end

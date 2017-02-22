require 'csv'
namespace :import_csv do
  # rake import_csv:import_csv\["/Users/Adia/Desktop/ids.csv"\]
  desc 'import csv'
  task :import_csv, :filepath do |t, args|
    filepath = args[:filepath]
    user_ids_to_migrate = []
    CSV.foreach(filepath, headers:true) do |row|
      user_ids_to_migrate << row['user_id']
    end
    puts user_ids_to_migrate.count
  end
  desc 'export csv'
  task :export_csv, :filepath do |_, args|
    filepath = args[:filepath]
    i = 1
    CSV.open(filepath, 'a+') do |csv|
      csv << ['user_id']
      while i < 6 do
        csv << [i]
        i += 1
      end
    end
  end
end

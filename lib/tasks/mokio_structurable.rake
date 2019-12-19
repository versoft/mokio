require 'rake'
require 'bcrypt'
namespace :mokio do
  desc "Structurable tree "
  namespace :structurable  do

    desc "Generate structure in mokio_structures"
    task :rebuild ,[:model_name] => :environment do |t, args|
      args.with_defaults(:model_name => nil)
      raise "Model name not specified: rake mokio:structurable:rebuild['model_name']" if args[:model_name].nil?

      begin
        model_name = args[:model_name]
        model = model_name.classify.constantize
        all = model.all

        puts "Rebuild structure for model #{model_name}".green
        puts "Found #{all.count} records in #{model_name}.all".green

        all.each do |record|
          if record.structure.nil?
            puts "Structure build successfull for record id: #{record.id}".green
            record.build_structure
            record.save
          else
            puts "Structure exists: skip record id: #{record.id}"
          end
        end

        puts "Structure rebuild end.".green
      rescue => e
        puts "Rake aborted"
        raise "Rescue in rebuild task: #{e.inspect}"
      end
    end
  end
end
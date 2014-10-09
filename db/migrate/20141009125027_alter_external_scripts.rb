class AlterExternalScripts < ActiveRecord::Migration

    def change

      if ActiveRecord::Base.connection.table_exists? :mokio_external_scripts

        change_table :mokio_external_scripts do |t|
          t.change :code, :string
          t.change :script, :text
        end

        change_table :mokio_external_scripts do |t|
          t.rename :code, :name
        end

      end

    end

end

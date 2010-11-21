# -*- coding: utf-8 -*-
require Rails.root.to_s + '/lib/batch_lock'
class CronDaemon < ActiveRecord::Base
  class << self
    # name    : 全てのタスクのおおもとになる
    # args    : 
    # comment : 
    # author  : chu
    def start
      settings = YAML.load_file(RAILS_ROOT + '/config/cron.yml')

      BatchLock.run('cron_daemon') do
        loop do
          time_now = Time.now
          p "beginning of a loop..."

          settings.each do |task_name, config|
            # このループは、この処理を実行するべきか判断
            next if 60 <= time_now.to_i % eval(config[:interval])
            p "execute #{task_name}"

            Thread.start do
              begin
                BatchLock.run(task_name) do
                  eval(config[:command])
                end
              rescue BatchLockException => e
                p e.message
              end
            end
          end

          p "sleeping now..."
          sleep 60
        end
      end
    end
  end
end

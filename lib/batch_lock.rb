# 同一処理を並行で走らせない様にするモジュール ポ
class BatchLockException < Exception; end
module BatchLock
  # 処理を排他ロックして走らせる
  def self.run(batch_name)
    FileUtils.mkdir(Rails.root.to_s + '/tmp/batch_lock') unless File.exists?(Rails.root.to_s + '/tmp/batch_lock')
    # batch_name をスコープとして排他処理される。
    File.open("#{Rails.root.to_s}/tmp/batch_lock/#{batch_name}", 'w') do |f|
      if f.flock(File::LOCK_EX | File::LOCK_NB)
        yield
      else
        raise BatchLockException.new
      end
    end
  end
 
  # 処理が走っているか確認する
  def self.running?(batch_name)
    FileUtils.mkdir(Rails.root.to_s + '/tmp/batch_lock') unless File.exists?(Rails.root.to_s + '/tmp/batch_lock')
    # ロック用のファイル名は、バッチごとにユニークにする。
    File.open("#{Rails.root.to_s}/tmp/batch_lock/#{batch_name}", 'w') do |f|
      ! f.flock(File::LOCK_EX | File::LOCK_NB)
    end
  end
end

require "fastercsv"
require "gcalapi"
require "kconv"

module DataExport

  def make_csv_text(lists)
    csv_text = ""

    csv_text = FasterCSV.generate do |csv|
      csv << ["タイトル", "開始", "終了", "時間"]
      lists.each do |list|
        csv << [list[:title], list[:st].to_time.localtime.strftime("%Y/%m/%d %H:%M"), list[:en].to_time.localtime.strftime("%Y/%m/%d %H:%M"),(list[:en].to_time-list[:st].to_time)/(60*60) ]
      end
    end

    # SJISに変換
    csv_text = Kconv.tosjis(csv_text)

    return csv_text
  end
end

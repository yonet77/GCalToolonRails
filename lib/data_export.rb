require "fastercsv"
require "gcalapi"
require "kconv"

module DataExport

  def make_csv_text(lists)
    csv_text = ""

    csv_text = FasterCSV.generate do |csv|
      csv << ["コード","タイトル", "開始日", "開始", "終了", "時間"]
      lists.each do |list|
        csv << [list[:code], list[:title], list[:st_date], list[:st].strftime("%Y/%m/%d %H:%M"), list[:en].strftime("%Y/%m/%d %H:%M"), list[:time] ]
      end
    end

    # SJISに変換
    csv_text = Kconv.tosjis(csv_text)

    return csv_text
  end
end

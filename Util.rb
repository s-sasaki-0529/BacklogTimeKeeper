require 'date'
class Util

  # 日付文字列をDateオブジェクトに変換する
  # 引数が既にDateの場合そのまま戻す
  def self.strToDate(str)
    str.class == Date   and return str
    str.class == String and return Date.parse(str)
    return nil
  end

  # Dateオブジェクトを文字列に変換する
  # 引数が既に文字列の場合そのまま戻す
  def self.dateToStr(date)
    date.class == Date   and return date.to_s
    date.class == String and return date
  end

  # 指定した日付が特定の期間に含まれているかを戻す
  def self.periodIn?(date, date_from, date_to)
    date      = Util.strToDate(date)
    date_from = Util.strToDate(date_from)
    date_to   = Util.strToDate(date_to)
    return date_from <= date && date <= date_to
  end

  # 指定した日を含む週の月曜日と金曜日の日付を取得
  # 週は月曜に始まり、土日で終了するものとする
  def self.getWeeklyDate(date)
    date  = Util.strToDate(date)
    cwday = date.cwday
    return {
      date_from: date + (1 - cwday),
      date_to:   date + (5 - cwday),
    }
  end

  # 指定した日を含む月の初日と最終日の日付を取得
  def self.getMonthlyDate(date)
    date = Util.strToDate(date)
    return {
      date_from: Date.new(date.year, date.month),
      date_to:   Date.new(date.year, date.month, -1),
    }
  end

  # 日付時刻文字列を9時間進めてDateTimeオブジェクトに変換する
  def self.slide9hours(datetime)
    datetime.class == String and datetime = DateTime.parse(datetime)
    return datetime + Rational(9, 24)
  end

  # 外部スクリプトを呼び出して、チャットワークの表示名に課題キーを付与する
  # チャットワークの本来の表示名は環境変数で渡す
  def self.setIssueKeyToChatwork_name(issue_key)
    name = ENV['CHATWORK_DEFAULT_NAME']
    `python ChangeChatworkName.py "#{name}@#{issue_key}"`
  end

  # 外部スクリプトを呼び出して、チャットワークの表示名を元に戻す
  # チャットワークの本来の表示名は環境変数で渡す
  def self.resetChatworkName
    name = ENV['CHATWORK_DEFAULT_NAME']
    `python ChangeChatworkName.py "#{name}"`
  end

end

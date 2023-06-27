class GildedRose
  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros"
  CONJURED = "Conjured Mana Cake"

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if item.name == SULFURAS
      class_name = "RegularItem"
      class_name = "AgedBrieItem" if item.name == AGED_BRIE
      class_name = "BackstagePassesItem" if item.name == BACKSTAGE_PASSES
      class_name = "ConjuredItem" if item.name == CONJURED

      specialized_item = Object.const_get(class_name).new(item)
      specialized_item.update_quality
    end
  end
end

class ConjuredItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def decrease_quality()
    item.quality -= 2 if item.quality > 0
  end

  def update_quality()
    item.sell_in -= 1
    decrease_quality
    decrease_quality if item.sell_in < 0
  end
end

class RegularItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def decrease_quality()
    item.quality -= 1 if item.quality > 0
  end

  def update_quality()
    item.sell_in -= 1
    decrease_quality
    decrease_quality if item.sell_in < 0
  end
end

class BackstagePassesItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def increase_quality()
    item.quality += 1 if item.quality < 50
  end

  def update_quality()
    item.sell_in -= 1
    increase_quality
    increase_quality if item.sell_in < 10
    increase_quality if item.sell_in < 5
    item.quality = 0 if item.sell_in < 0
  end
end

class AgedBrieItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def increase_quality()
    item.quality += 1 if item.quality < 50
  end

  def update_quality()
    item.sell_in -= 1
    increase_quality
    increase_quality if item.sell_in < 0
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

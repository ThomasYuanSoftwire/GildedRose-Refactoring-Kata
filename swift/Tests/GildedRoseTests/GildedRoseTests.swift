@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    func testSellinOfNormalItemsDecreasesByOneEveryDay() throws{
        let items = [Item(name: "foo", sellIn: 1, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].sellIn, 0)
    }
    func testQualityOfNormalItemsDecreasesByOneEveryDayBeforeSellout() throws{
        let items = [Item(name: "foo", sellIn: 10, quality: 1)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 0)
    }
    func testQualityOfNormalItemDecreasesByTwoEveryDayAfterSellout() throws{
        let items = [Item(name: "foo", sellIn: 0, quality: 2)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 0)
    }
    func testAgedBrieIncreasesQualityAsOlder() throws{
        let items = [Item(name: "Aged Brie", sellIn: 10, quality: 1)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssert(app.items[0].quality > 1)
    }
    
    func testQualityMaximum50() throws{
        let items = [Item(name: "Aged Brie", sellIn: 10, quality: 50), Item(name: "foo", sellIn: 10, quality: 50), Item(name: "Conjured item", sellIn: 10, quality: 50), Item(name: "Backstage", sellIn: 10, quality: 50)]
        let app = GildedRose(items: items)
        app.updateQuality()
        var allTrue = true
        for item in items{
            if item.quality > 50{
                allTrue = false
            }
        }
        XCTAssert(allTrue)
    }
    func testQualityMinimum0() throws{
        let items = [Item(name: "Aged Brie", sellIn: 10, quality: 0), Item(name: "foo", sellIn: 10, quality: 0), Item(name: "Conjured item", sellIn: 10, quality: 0), Item(name: "Backstage", sellIn: 10, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()
        var allTrue = true
        for item in items{
            if item.quality < 0{
                allTrue = false
            }
        }
        XCTAssert(allTrue)
    }
    func testSulfurasQualityDoesNotChange() throws{
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 10)
    }
    func testSulfurasSellInDoesNotChange() throws{
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].sellIn, 10)
    }
    func testBackstagePassesIncreaseQualityByTwoWhenTenDaysLeft() throws{
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 12)
    }
    func testBackstagePassesIncreaseQualityByThreeWhenFIveDaysLeft() throws{
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 13)
    }
    func testBackstagePassesQualityDropsToZeroAfterConcert() throws{
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 0)
    }
    func testDifferentBackstagePassesIncreaseQualityByTwoWhenTenDaysLeft() throws{
        let items = [Item(name: "Backstage passes to a Eminem concert", sellIn: 10, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 12)
    }
    func testDifferentBackstagePassesIncreaseQualityByThreeWhenFIveDaysLeft() throws{
        let items = [Item(name: "Backstage passes to a Eminem concert", sellIn: 5, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 13)
    }
    func testDifferentBackstagePassesQualityDropsToZeroAfterConcert() throws{
        let items = [Item(name: "Backstage passes to a Eminem concert", sellIn: 0, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 0)
    }
    func testConjuredItemsDegradesTwiceAsFastBeforeSellout() throws{
        let items = [Item(name: "Conjured Mana Cake", sellIn: 5, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 8)
    }
    func testConjuredItemsDegradesTwiceAsFastAfterSellout() throws{
        let items = [Item(name: "Conjured Mana Cake", sellIn: -5, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 6)
    }
    func testDifferentConjuredItemsDegradesTwiceAsFastBeforeSellout() throws{
        let items = [Item(name: "Conjured Muffin", sellIn: 5, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 8)
    }
    func testDifferentConjuredItemsDegradesTwiceAsFastAfterSellout() throws{
        let items = [Item(name: "Conjured Muffin", sellIn: -5, quality: 10)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 6)
    }
}

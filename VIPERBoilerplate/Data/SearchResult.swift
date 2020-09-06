import Foundation

final class SearchResult: Codable {

    enum CodingKeys: String, CodingKey {
        case abstract = "Abstract"
        case abstractText = "AbstractText"
        case abstractSource = "AbstractSource"
        case abstractURL = "AbstractURL"
        case image = "Image"
        case heading = "Heading"
    }

    /** topic summary (can contain HTML, e.g. italics) */
    private var abstract: String

    /** topic summary (with no HTML) */
    private var abstractText: String

    /** name of Abstract source */
    private var abstractSource: String

    /** deep link to expanded topic page in AbstractSource */
    private var abstractURL: String

    /** link to image that goes with Abstract */
    private var image: String

    /** name of topic that goes with Abstract */
    private var heading: String

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            if let abstract = try values.decodeIfPresent(String.self,
                                                         forKey: SearchResult.CodingKeys.abstract),
                let abstractText = try values.decodeIfPresent(String.self,
                                                              forKey: SearchResult.CodingKeys.abstractText),
                let abstractSource = try values.decodeIfPresent(String.self,
                                                                forKey: SearchResult.CodingKeys.abstractSource),
                let abstractURL = try values.decodeIfPresent(String.self,
                                                             forKey: SearchResult.CodingKeys.abstractURL),
                let image = try values.decodeIfPresent(String.self,
                                                       forKey: SearchResult.CodingKeys.image),
                let heading = try values.decodeIfPresent(String.self,
                                                         forKey: SearchResult.CodingKeys.heading) {

                self.abstract = abstract
                self.abstractText = abstractText
                self.abstractSource = abstractSource
                self.abstractURL = abstractURL
                self.image = image
                self.heading = heading
            } else {
                throw NSError(domain: "", code: 0, userInfo: nil)
            }
        } catch let error as NSError {
            throw error
        }
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.abstract, forKey: CodingKeys.abstract.rawValue)
        aCoder.encode(self.abstractText, forKey: CodingKeys.abstractText.rawValue)
        aCoder.encode(self.abstractSource, forKey: CodingKeys.abstractSource.rawValue)
        aCoder.encode(self.abstractURL, forKey: CodingKeys.abstractURL.rawValue)
        aCoder.encode(self.image, forKey: CodingKeys.image.rawValue)
        aCoder.encode(self.heading, forKey: CodingKeys.heading.rawValue)
    }
}

/*

 Answer: instant answer
 AnswerType: type of Answer, e.g. calc, color, digest, info, ip, iploc, phone, pw, rand, regexp, unicode, upc, or zip (see the tour page for examples).

 Definition: dictionary definition (may differ from Abstract)
 DefinitionSource: name of Definition source
 DefinitionURL: deep link to expanded definition page in DefinitionSource

 RelatedTopics: array of internal links to related topics associated with Abstract
   Result: HTML link(s) to related topic(s)
   FirstURL: first URL in Result
   Icon: icon associated with related topic(s)
     URL: URL of icon
     Height: height of icon (px)
     Width: width of icon (px)
   Text: text from first URL

 Results: array of external links associated with Abstract
   Result: HTML link(s) to external site(s)
   FirstURL: first URL in Result
   Icon: icon associated with FirstURL
     URL: URL of icon
     Height: height of icon (px)
     Width: width of icon (px)
   Text: text from FirstURL

 Type: response category, i.e. A (article), D (disambiguation), C (category), N (name), E (exclusive), or nothing.

 Redirect: !bang redirect URL
 
 */

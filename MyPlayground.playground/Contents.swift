import UIKit


class Person: Codable {
    var name, dob: String?
}


let jsonString = "[{\"name\":\"Sladdar\",\"dob\":\"1992\\/01\\/20\"},{\"name\":\"MoghulKahn\",\"dob\":\"1989\\/11\\/12\"},{\"name\":\"Invoker\",\"dob\":\"1890\\/04\\/21\"},{\"name\":\"Skogul\",\"dob\":\"1952\\/05\\/10\"},{\"name\":\"Silencer\",\"dob\":\"2000\\/04\\/23\"},{\"name\":\"Tom\",\"dob\":\"2002\\/11\\/01\"},{\"name\":\"Jack\",\"dob\":\"1982\\/12\\/25\"},{\"name\":\"Darion\",\"dob\":\"1988\\/12\\/07\"},{\"name\":\"Beth\",\"dob\":\"1986\\/06\\/22\"} ,{\"name\":\"Garo\",\"dob\":\"1953\\/12\\/13\"},{\"name\":\"Deva\",\"dob\":\"1946\\/07\\/14\"},{\"name\":\"Leo\",\"dob\":\"2003\\/08\\/08\"},{\"name\":\"Fran\",\"dob\":\"1996\\/11\\/18\"},{\"name\":\"Vero\",\"dob\":\"2001\\/01\\/23\"},{\"name\":\"Alicia\",\"dob\":\"2003\\/02\\/02\"},{\"name\":\"Bernard\",\"dob\":\"1994\\/10\\/23\"},{\"name\":\"Shannon\",\"dob\":\"2001\\/01\\/19\"},{\"name\":\"Herne\",\"dob\":\"1994\\/01\\/06\"},{\"name\":\"Miho\",\"dob\":\"1967\\/10\\/03\"}]"

var persons : [Person]?

do {
    
    let data = jsonString.data(using: .utf8)!
    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Any] {
        
        let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
        persons = try JSONDecoder().decode([Person].self, from: jsonData)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        let dobSortedPersons = persons?.filter {
            !isLeapYear(dateFormatter.date(from: $0.dob!)!)
        }.sorted(by: { (person1, person2) -> Bool in
            dateFormatter.date(from: person1.dob!)! < dateFormatter.date(from: person2.dob!)!
        })
        
        for p in dobSortedPersons! {
            print(p.name!+" "+p.dob!)
        }
    }
}
catch {
    print("json error: \(error).")
}

func isLeapYear(_ date: Date) -> Bool {
    
    let calendar = NSCalendar.current
    let components = calendar.dateComponents([.year], from: date)
    let year = components.year!
    let isLeapYear = ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0))
    return isLeapYear
}

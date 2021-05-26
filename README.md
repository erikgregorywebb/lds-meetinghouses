## Meetinghouses: A Proxy for Measuring Growth in the LDS Church

### Background

When the Church of Jesus Christ of Latter-Day Saints was organized in a small town in New York in 1830, there were only six members. Today, the Mormon Church has grown to over [16 million members](https://www.sltrib.com/religion/2019/04/06/lds-church-tops-million/), with congregations in [160 countries](https://www.churchofjesuschrist.org/study/ensign/2005/01/news-of-the-church/church-growing-in-more-than-160-countries?lang=eng).

Leaders of the church have [taught](https://www.churchofjesuschrist.org/study/general-conference/2007/10/the-stone-cut-out-of-the-mountain?lang=eng) that this extraordinary growth is fulfillment of the Old Testament prophecy(3). [Daniel 2:31–45](https://www.churchofjesuschrist.org/study/scriptures/ot/dan/2?lang=eng) describes a stone “cut out of the mountain without hands” which would roll forth to fill the whole earth. The Church, believed to be the kingdom of God on earth, is prophesied to spread to "every nation, kindred, tongue, and people.” (See [D&C 42:58](https://abn.churchofjesuschrist.org/study/scriptures/dc-testament/dc/42?lang=eng))

Given the scope of that mandate, it’s no wonder that many parties, inside and outside the church, are interested in measuring and tracking the growth of the LDS Church. While [high-level membership metrics](https://newsroom.churchofjesuschrist.org/facts-and-statistics) are shared bi-annually by church leadership, country- or state-specific trends are not provided. **This project is an attempt to more preciously measure micro church growth by tracking changes in the number and distribution of meetinghouses and wards<sup>1</sup> over time.**

*<sup>1</sup>Wards are the basic organizational unit of the Church; e.g. a congregation.*

### Data Source

To help members or visitors locate worship services nearby, the Church provides a [meetinghouse locator](https://www.churchofjesuschrist.org/maps/meetinghouses/@33.228243,-111.579049,14) tool. After entering an address, the user is shown nearby meetinghouses and hours of ward<sup>2</sup> worship services. 

Since there are many thousands of meetinghouses owned by the Church across the world, it would be difficult impossible to collect meetinghouse and ward details manually. However, using the [back-end web service](https://ws.churchofjesuschrist.org/ws/maps/v1.0/services/) that powers the meetinghouse locator tool, it's possible to query the full list of meetinghouses, along with the ward units assigned to those meetinghouses. You can find a copy of the code used to extract and clean the data here.

*Note: The meetinghouse locator is publicly avlaible online, and is not restricted to authenticated users. Consequencly, the underlying meetinghouse data is pressumed to be open and avaliable for collection and analysis.*

### Data Structure

There are currently two data outputs: (1) a list of the ~19,000+ meetinghouses owned or operated by the Church and (2) a list of ~30,000+ wards or other organizaitonal units "assigned" to those meetinghouses. Below is an example using some of the fields from the tables to make this relationship more clear.

**Meetinghouses Table**

| id  | address  | latitude | longitude |
| ------------- | ------------- | ------------- | ------------- |
| 5272017-01-01  | 6695 South 2200 West, West Jordan, Utah 84084-2201 | 40.629395  | -111.9480540 |

**Meetinghouse Assignments Table**

| meetinghouse_id  | assignment_id | assignment_type  | assignment_name |
| ------------- | ------------- | ------------- | ------------- |
| 5272017-01-01  | 125857  | ward  | Colonial Park Ward  |
| 5272017-01-01  | 170534  | ward  | Meadowland Ward  |

In other words, the first table says there's a meetinghouse (church building) on 6695 South 2200 West in West Jordan, UT. The second table says that there are two wards that meet in that building, the Colonial Park Ward and the Meadowland Ward.

### Use Cases

The data described thus far represents a snapshot in time. For the day it's compiled, the data describes the distribution of meetinghouses and wards around the world at that time. It could be used to answer these kinds of questions:
- How many meetinghouses are there currently in Sao Paulo, Brazil?
- How many wards are there currently in Coconut Creek, Florida?

While these are interesting questions, the bigger prize is understanding how the number of meetinghouses and wards in each country, state, or zipcode is **changing over time**. To acomplish this, we need to capture and compare snapshots at regular intervals. For example, by comparing the list of meetinghouses in January 2020 and June 2021, we can infer which meetinghouses are new, and where they are located, and which meetinghouses have been closed, and where they are located. **Ultimately, this should serve as a kind of (imperfect) proxy for growth or migration effects within the church**. My intention is to capture monthly snapshots of this data, and then sitch together to analyze micro trends in growth.

### Data Download

#### May 2021
- [LDS Meetinghouses](https://github.com/erikgregorywebb/lds-meetinghouses/blob/main/data/lds_meetinghouses_20210524.csv?raw=true) (4.02 MB)
- [LDS Meetinghouse Assignments](https://github.com/erikgregorywebb/lds-meetinghouses/blob/main/data/lds_meetinghouse_assignments_20210524.csv?raw=true) (2.13 MB)

### Contact

Have a question or suggestion? Create a new issue via GitHub [here](https://github.com/erikgregorywebb/lds-meetinghouses/issues/new).

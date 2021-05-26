### Background

When the Church of Jesus Christ of Latter-Day Saints was organized in a small town in New York in 1830, there were only six members. Today, the Mormon Church has grown to over [16 million members](https://www.sltrib.com/religion/2019/04/06/lds-church-tops-million/), with congregations in [160 countries](https://www.churchofjesuschrist.org/study/ensign/2005/01/news-of-the-church/church-growing-in-more-than-160-countries?lang=eng).

Leaders of the church have [taught](https://www.churchofjesuschrist.org/study/general-conference/2007/10/the-stone-cut-out-of-the-mountain?lang=eng) that this extraordinary growth is fulfillment of the Old Testament prophecy. [Daniel 2:31–45](https://www.churchofjesuschrist.org/study/scriptures/ot/dan/2?lang=eng) describes a stone “cut out of the mountain without hands” which would roll forth to fill the whole earth. Like the stone, the Church is prophesied to spread to and fill "every nation, kindred, tongue, and people.” (See [D&C 42:58](https://abn.churchofjesuschrist.org/study/scriptures/dc-testament/dc/42?lang=eng))

Given the ambitious scope of that prophecy, it’s no wonder that many parties, inside and outside the organization, are interested in measuring and tracking the growth of the LDS Church. While [high-level membership metrics](https://newsroom.churchofjesuschrist.org/facts-and-statistics) are shared bi-annually by church leadership, country or state-specific trends are not provided. **This project is an attempt to more precisely measure church growth by tracking changes in the number and distribution of meetinghouses and wards<sup>1</sup> over time.**

*<sup>1</sup>Wards are the basic organizational unit of the Church, e.g., a congregation.*

### Data Source

To help members or visitors locate worship services nearby, the Church provides a [meetinghouse locator](https://www.churchofjesuschrist.org/maps/meetinghouses/@33.228243,-111.579049,14) tool. After entering an address, the user is shown nearby meetinghouses and hours of ward worship services. 

Since there are many thousands of meetinghouses owned by the Church across the world, it would be very difficult to collect meetinghouse and ward details manually. However, using the [back-end web service](https://ws.churchofjesuschrist.org/ws/maps/v1.0/services/) that powers the meetinghouse locator, it's possible to query the full list of meetinghouses, along with the ward units assigned to those meetinghouses. You can find a copy of the code used to extract and clean the data [here](https://github.com/erikgregorywebb/lds-meetinghouses/blob/main/scripts/base.R).

*Note: The meetinghouse locator is publicly available online and is not restricted to authenticated users. Consequently, the underlying meetinghouse data is presumed to be open and available for collection and analysis.*

### Data Structure

There are currently two data outputs: (1) a list of the ~19,000+ meetinghouses owned or operated by the Church and (2) a list of ~30,000+ wards or other organizational  units "assigned" to those meetinghouses. Below is a simple example to make this relationship clear:

**Meetinghouses Table**

| id  | address  | city | state | country | latitude | longitude |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| 5272017-01-01  | 6695 S 2200 W | West Jordan | Utah | USA | 40.629395  | -111.9480540 |

**Meetinghouse Assignments Table**

| meetinghouse_id  | assignment_id | assignment_type  | assignment_name |
| ------------- | ------------- | ------------- | ------------- |
| 5272017-01-01  | 125857  | ward  | Colonial Park Ward  |
| 5272017-01-01  | 170534  | ward  | Meadowland Ward  |

In other words, the first table says there's a meetinghouse (church building) on 6695 South 2200 West in West Jordan, UT. The second table says that there are two wards that meet in that building, the Colonial Park Ward and the Meadowland Ward.

### Use Cases

The data described above represents a snapshot in time. It describes the distribution of meetinghouses and wards around the world at the moment the data is compiled, and could be used to answer these kinds of questions:
- How many meetinghouses are there currently in Sao Paulo, Brazil?
- How many wards are there currently in Coconut Creek, Florida?

While these are interesting questions, the bigger prize is understanding how the number of meetinghouses and wards in each country, state, or zip code is **changing over time**. To accomplish  this, we need to capture and compare snapshots at regular intervals. 

For example, by comparing the list of meetinghouses in January 2020 and June 2021, we could infer which meetinghouses are new, where they are located, which meetinghouses have been closed, and where they are located. **Ultimately, this should serve as a kind of (imperfect) proxy for growth or migration effects within the church**. My intention is to capture monthly snapshots of this data, and then stich it together to analyze micro trends in growth.

### Data Download

**May 2021**
- [Meetinghouses](https://github.com/erikgregorywebb/lds-meetinghouses/blob/main/data/lds_meetinghouses_20210524.csv) (4.02 MB)
- [Meetinghouse Assignments](https://github.com/erikgregorywebb/lds-meetinghouses/blob/main/data/lds_meetinghouse_assignments_20210524.csv) (2.13 MB)

### Contact

Have a question, suggestion, or idea? Create a new issue via GitHub [here](https://github.com/erikgregorywebb/lds-meetinghouses/issues/new).

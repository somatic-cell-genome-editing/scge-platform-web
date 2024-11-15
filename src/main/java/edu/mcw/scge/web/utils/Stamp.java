package edu.mcw.scge.web.utils;

import java.text.SimpleDateFormat;
import java.time.LocalDate;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: jdepons
 * Date: Feb 19, 2009
 * Time: 12:08:22 PM
 * To change this template use File | Settings | File Templates.
 */
public class Stamp {

    public static SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd - hh:mm:ss.SSS");
    public static void it(String desc) {
        System.out.println(sf.format(new Date()) + " - " + desc);
    }

//    public String getpercentage(String dateTimeStart, String dateTimeExpiration) {
//        ZoneId zone = ZoneId.systemDefault();
//
//        ZonedDateTime start = LocalDateTime.parse(dateTimeStart.replace( " " , "T" ) )
//                .atZone(zone);
//        ZonedDateTime end = LocalDateTime.parse(dateTimeExpiration.replace( " " , "T" ) )
//                .atZone(zone);
//
//        long total = ChronoUnit.MICROS.between(start, end);
//        long passed = ChronoUnit.MICROS.between(start, ZonedDateTime.now(zone));
//
//        long percentage = passed * 100 / total;
//
//       return (String.valueOf(percentage) + " %");
//    }
    public String getpercentage(String dateTimeStart, String completionDate, String lastUpdateDate) {
       String[] start= dateTimeStart.split("-");
        String[] completion= completionDate.split("-");
        String[] update= lastUpdateDate.split("-");
        if(start.length<3){
            dateTimeStart+="-01";
        }
        if(completion.length<3){
            completionDate+="-01";
        }
        if(update.length<3){
            lastUpdateDate+="-01";
        }
        ZoneId zone = ZoneId.systemDefault();
        ZonedDateTime startTime = LocalDateTime.parse(dateTimeStart+" 00:00:00".replace( " " , "T" ) )
                .atZone(zone);
        ZonedDateTime end = LocalDateTime.parse(lastUpdateDate+ " 00:00:00".replace( " " , "T" ) )
                .atZone(zone);
        ZonedDateTime completionTime = LocalDateTime.parse(completionDate+ " 00:00:00".replace( " " , "T" ) )
                .atZone(zone);


        long total = ChronoUnit.MICROS.between(startTime, completionTime);
        long passed = ChronoUnit.MICROS.between(startTime, end);
//        long passed = ChronoUnit.MICROS.between(startTime, ZonedDateTime.now(zone));

        long percentage = passed * 100 / total;

       return (String.valueOf(percentage) + " %");
    }
}


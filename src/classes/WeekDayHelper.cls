public with sharing class WeekDayHelper {
    public static Date previousWeek(Datetime dt){
        String weekday = dt.format('EEE');
        switch on weekday{
            when 'Mon'{
            }
            when 'Tue'{
                dt = dt.addDays(-1);
            }
            when 'Wen'{
                dt = dt.addDays(-2);
            }
            when 'Thu'{
                dt = dt.addDays(-3);
            }
            when 'Fri'{
                dt = dt.addDays(-4);
            }
            when 'Sat'{
                dt = dt.addDays(-5);
            }
            when 'Sun'{
                dt = dt.addDays(-6);
            }
        }
        return Date.newInstance(dt.year(), dt.month(), dt.day());
    }
    public static Date nextWeek(Datetime dt){
        String weekday = dt.format('EEE');
        switch on weekday{
            when 'Mon'{
                dt = dt.addDays(6);
            }
            when 'Tue'{
                dt = dt.addDays(5);
            }
            when 'Wen'{
                dt = dt.addDays(4);
            }
            when 'Thu'{
                dt = dt.addDays(3);
            }
            when 'Fri'{
                dt = dt.addDays(2);
            }
            when 'Sat'{
                dt = dt.addDays(1);
            }
            when 'Sun'{
            }
        }
        return Date.newInstance(dt.year(), dt.month(), dt.day());
    }
}
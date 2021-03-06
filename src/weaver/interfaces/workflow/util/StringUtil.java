package weaver.interfaces.workflow.util;

/**
 * 字符工具类
 */
public class StringUtil {
    /**
     * 去除字符串首尾出现的某个字符
     * @param source 源字符串
     * @param element 需要去除的字符
     * @return
     */
    public static String trimFirstAndLastChar(String source, char element) {
        boolean beginIndexFlag = true;
        boolean endIndexFlag = true;
        do {
            int beginIndex = source.indexOf(element) == 0 ? 1 : 0;
            int endIndex = source.lastIndexOf(element) + 1 == source.length() ? source.lastIndexOf(element) : source.length();
            source = source.substring(beginIndex, endIndex);
            beginIndexFlag = (source.indexOf(element) == 0);
            endIndexFlag = (source.lastIndexOf(element) + 1 == source.length());
        } while (beginIndexFlag || endIndexFlag);
            return source;
    }
}

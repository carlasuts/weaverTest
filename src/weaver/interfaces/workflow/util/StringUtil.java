package weaver.interfaces.workflow.util;

/**
 * �ַ�������
 */
public class StringUtil {
    /**
     * ȥ���ַ�����β���ֵ�ĳ���ַ�
     * @param source Դ�ַ���
     * @param element ��Ҫȥ�����ַ�
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

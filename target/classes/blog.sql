/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 80017
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80017
 File Encoding         : 65001

 Date: 17/03/2021 15:44:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appreciation` bit(1) NOT NULL,
  `commentabled` bit(1) NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `first_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `published` bit(1) NOT NULL,
  `recommend` bit(1) NOT NULL,
  `share_statement` bit(1) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `views` int(11) NULL DEFAULT NULL,
  `type_id` bigint(20) NULL DEFAULT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK292449gwg5yf7ocdlmswv9w4j`(`type_id`) USING BTREE,
  INDEX `FK8ky5rrsxh01nkhctmo7d48p82`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_blog
-- ----------------------------
INSERT INTO `t_blog` VALUES (2, b'1', b'1', '1. 会话技术\r\n    1. Cookie\r\n    2. Session\r\n2. JSP：入门学习\r\n会话技术\r\n1. 会话：一次会话中包含多次请求和响应。\r\n    * 一次会话：浏览器第一次给服务器资源发送请求，会话建立，直到有一方断开为止\r\n2. 功能：在一次会话的范围内的多次请求间，共享数据\r\n3. 方式：\r\n    1. 客户端会话技术：Cookie\r\n    2. 服务器端会话技术：Session\r\nCookie：\r\n1. 概念：客户端会话技术，将数据保存到客户端\r\n\r\n2. 快速入门：\r\n    * 使用步骤：\r\n        1. 创建Cookie对象，绑定数据\r\n            * new Cookie(String name, String value) \r\n        2. 发送Cookie对象\r\n            * response.addCookie(Cookie cookie) \r\n        3. 获取Cookie，拿到数据\r\n            * Cookie[]  request.getCookies()  \r\n\r\n\r\n3. 实现原理\r\n    * 基于响应头set-cookie和请求头cookie实现\r\n\r\n4. cookie的细节\r\n    1. 一次可不可以发送多个cookie?\r\n        * 可以\r\n        * 可以创建多个Cookie对象，使用response调用多次addCookie方法发送cookie即可。\r\n    2. cookie在浏览器中保存多长时间？\r\n        1. 默认情况下，当浏览器关闭后，Cookie数据被销毁\r\n        2. 持久化存储：\r\n            * setMaxAge(int seconds)\r\n                1. 正数：将Cookie数据写到硬盘的文件中。持久化存储。并指定cookie存活时间，时间到后，cookie文件自动失效\r\n                2. 负数：默认值\r\n                3. 零：删除cookie信息\r\n    3. cookie能不能存中文？\r\n        * 在tomcat 8 之前 cookie中不能直接存储中文数据。\r\n            * 需要将中文数据转码---一般采用URL编码(%E3)\r\n        * 在tomcat 8 之后，cookie支持中文数据。特殊字符还是不支持，建议使用URL编码存储，URL解码解析\r\n    4. cookie共享问题？\r\n        1. 假设在一个tomcat服务器中，部署了多个web项目，那么在这些web项目中cookie能不能共享？\r\n            * 默认情况下cookie不能共享\r\n\r\n            * setPath(String path):设置cookie的获取范围。默认情况下，设置当前的虚拟目录\r\n                * 如果要共享，则可以将path设置为\"/\"\r\n\r\n\r\n        2. 不同的tomcat服务器间cookie共享问题？\r\n            * setDomain(String path):如果设置一级域名相同，那么多个服务器之间cookie可以共享\r\n                * setDomain(\".baidu.com\"),那么tieba.baidu.com和news.baidu.com中cookie可以共享\r\n\r\n\r\n5. Cookie的特点和作用\r\n    1. cookie存储数据在客户端浏览器\r\n    2. 浏览器对于单个cookie 的大小有限制(4kb) 以及 对同一个域名下的总cookie数量也有限制(20个)\r\n\r\n    * 作用：\r\n        1. cookie一般用于存出少量的不太敏感的数据\r\n        2. 在不登录的情况下，完成服务器对客户端的身份识别\r\n\r\n6. 案例：记住上一次访问时间\r\n    1. 需求：\r\n        1. 访问一个Servlet，如果是第一次访问，则提示：您好，欢迎您首次访问。\r\n        2. 如果不是第一次访问，则提示：欢迎回来，您上次访问时间为:显示时间字符串\r\n\r\n    2. 分析：\r\n        1. 可以采用Cookie来完成\r\n        2. 在服务器中的Servlet判断是否有一个名为lastTime的cookie\r\n            1. 有：不是第一次访问\r\n                1. 响应数据：欢迎回来，您上次访问时间为:2018年6月10日11:50:20\r\n                2. 写回Cookie：lastTime=2018年6月10日11:50:01\r\n            2. 没有：是第一次访问\r\n                1. 响应数据：您好，欢迎您首次访问\r\n                2. 写回Cookie：lastTime=2018年6月10日11:50:01\r\n\r\n    3. 代码实现：\r\n        package cn.itcast.cookie;\r\n\r\n        import javax.servlet.ServletException;\r\n        import javax.servlet.annotation.WebServlet;\r\n        import javax.servlet.http.Cookie;\r\n        import javax.servlet.http.HttpServlet;\r\n        import javax.servlet.http.HttpServletRequest;\r\n        import javax.servlet.http.HttpServletResponse;\r\n        import java.io.IOException;\r\n        import java.net.URLDecoder;\r\n        import java.net.URLEncoder;\r\n        import java.text.SimpleDateFormat;\r\n        import java.util.Date;\r\n\r\n\r\n    @WebServlet(\"/cookieTest\")\r\n    public class CookieTest extends HttpServlet {\r\n        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {\r\n            //设置响应的消息体的数据格式以及编码\r\n            response.setContentType(\"text/html;charset=utf-8\");\r\n\r\n            //1.获取所有Cookie\r\n            Cookie[] cookies = request.getCookies();\r\n            boolean flag = false;//没有cookie为lastTime\r\n            //2.遍历cookie数组\r\n            if(cookies != null && cookies.length > 0){\r\n                for (Cookie cookie : cookies) {\r\n                    //3.获取cookie的名称\r\n                    String name = cookie.getName();\r\n                    //4.判断名称是否是：lastTime\r\n                    if(\"lastTime\".equals(name)){\r\n                        //有该Cookie，不是第一次访问\r\n\r\n                        flag = true;//有lastTime的cookie\r\n\r\n                        //设置Cookie的value\r\n                        //获取当前时间的字符串，重新设置Cookie的值，重新发送cookie\r\n                        Date date  = new Date();\r\n                        SimpleDateFormat sdf = new SimpleDateFormat(\"yyyy年MM月dd日 HH:mm:ss\");\r\n                        String str_date = sdf.format(date);\r\n                        System.out.println(\"编码前：\"+str_date);\r\n                        //URL编码\r\n                        str_date = URLEncoder.encode(str_date,\"utf-8\");\r\n                        System.out.println(\"编码后：\"+str_date);\r\n                        cookie.setValue(str_date);\r\n                        //设置cookie的存活时间\r\n                        cookie.setMaxAge(60 * 60 * 24 * 30);//一个月\r\n                        response.addCookie(cookie);\r\n\r\n\r\n                        //响应数据\r\n                        //获取Cookie的value，时间\r\n                        String value = cookie.getValue();\r\n                        System.out.println(\"解码前：\"+value);\r\n                        //URL解码：\r\n                        value = URLDecoder.decode(value,\"utf-8\");\r\n                        System.out.println(\"解码后：\"+value);\r\n                        response.getWriter().write(\"<h1>欢迎回来，您上次访问时间为:\"+value+\"</h1>\");\r\n\r\n                        break;\r\n\r\n                    }\r\n                }\r\n            }\r\n\r\n\r\n            if(cookies == null || cookies.length == 0 || flag == false){\r\n                //没有，第一次访问\r\n\r\n                //设置Cookie的value\r\n                //获取当前时间的字符串，重新设置Cookie的值，重新发送cookie\r\n                Date date  = new Date();\r\n                SimpleDateFormat sdf = new SimpleDateFormat(\"yyyy年MM月dd日 HH:mm:ss\");\r\n                String str_date = sdf.format(date);\r\n                System.out.println(\"编码前：\"+str_date);\r\n                //URL编码\r\n                str_date = URLEncoder.encode(str_date,\"utf-8\");\r\n                System.out.println(\"编码后：\"+str_date);\r\n\r\n                Cookie cookie = new Cookie(\"lastTime\",str_date);\r\n                //设置cookie的存活时间\r\n                cookie.setMaxAge(60 * 60 * 24 * 30);//一个月\r\n                response.addCookie(cookie);\r\n\r\n                response.getWriter().write(\"<h1>您好，欢迎您首次访问</h1>\");\r\n            }\r\n\r\n\r\n        }\r\n\r\n        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {\r\n            this.doPost(request, response);\r\n        }\r\n    }', NULL, '/images/a3.jpg', '45', b'0', b'1', b'1', '会话技术', '2020-12-17 11:21:29', 2, 8, 1, NULL);
INSERT INTO `t_blog` VALUES (3, b'1', b'1', '1. 概念：\r\n    * Java Server Pages： java服务器端页面\r\n        * 可以理解为：一个特殊的页面，其中既可以指定定义html标签，又可以定义java代码\r\n        * 用于简化书写！！！\r\n\r\n\r\n2. 原理\r\n    * JSP本质上就是一个Servlet\r\n\r\n3. JSP的脚本：JSP定义Java代码的方式\r\n    1. <%  代码 %>：定义的java代码，在service方法中。service方法中可以定义什么，该脚本中就可以定义什么。\r\n    2. <%! 代码 %>：定义的java代码，在jsp转换后的java类的成员位置。\r\n    3. <%= 代码 %>：定义的java代码，会输出到页面上。输出语句中可以定义什么，该脚本中就可以定义什么。\r\n\r\n\r\n4. JSP的内置对象：\r\n    * 在jsp页面中不需要获取和创建，可以直接使用的对象\r\n    * jsp一共有9个内置对象。\r\n    * 今天学习3个：\r\n        * request\r\n        * response\r\n        * out：字符输出流对象。可以将数据输出到页面上。和response.getWriter()类似\r\n            * response.getWriter()和out.write()的区别：\r\n                * 在tomcat服务器真正给客户端做出响应之前，会先找response缓冲区数据，再找out缓冲区数据。\r\n                * response.getWriter()数据输出永远在out.write()之前\r\n\r\n5. 案例:改造Cookie案例', NULL, '/images/a3.jpg', '45', b'1', b'0', b'1', 'JSP：入门学习', '2020-12-17 11:20:52', 1, 3, 1, NULL);
INSERT INTO `t_blog` VALUES (5, b'0', b'0', '1. 概念：服务器端会话技术，在一次会话的多次请求间共享数据，将数据保存在服务器端的对象中。HttpSession\r\n2. 快速入门：\r\n    1. 获取HttpSession对象：\r\n        HttpSession session = request.getSession();\r\n    2. 使用HttpSession对象：\r\n        Object getAttribute(String name)  \r\n        void setAttribute(String name, Object value)\r\n        void removeAttribute(String name)  \r\n\r\n3. 原理\r\n    * Session的实现是依赖于Cookie的。\r\n\r\n\r\n4. 细节：\r\n    1. 当客户端关闭后，服务器不关闭，两次获取session是否为同一个？\r\n        * 默认情况下。不是。\r\n        * 如果需要相同，则可以创建Cookie,键为JSESSIONID，设置最大存活时间，让cookie持久化保存。\r\n             Cookie c = new Cookie(\"JSESSIONID\",session.getId());\r\n             c.setMaxAge(60*60);\r\n             response.addCookie(c);\r\n\r\n    2. 客户端不关闭，服务器关闭后，两次获取的session是同一个吗？\r\n        * 不是同一个，但是要确保数据不丢失。tomcat自动完成以下工作\r\n            * session的钝化：\r\n                * 在服务器正常关闭之前，将session对象系列化到硬盘上\r\n            * session的活化：\r\n                * 在服务器启动后，将session文件转化为内存中的session对象即可。\r\n\r\n    3. session什么时候被销毁？\r\n        1. 服务器关闭\r\n        2. session对象调用invalidate() 。\r\n        3. session默认失效时间 30分钟\r\n            选择性配置修改    \r\n            <session-config>\r\n                <session-timeout>30</session-timeout>\r\n            </session-config>\r\n\r\n 5. session的特点\r\n     1. session用于存储一次会话的多次请求的数据，存在服务器端\r\n     2. session可以存储任意类型，任意大小的数据\r\n\r\n    * session与Cookie的区别：\r\n        1. session存储数据在服务器端，Cookie在客户端\r\n        2. session没有数据大小限制，Cookie有\r\n        3. session数据安全，Cookie相对于不安全', NULL, '/images/a3.jpg', '45', b'1', b'1', b'0', 'Session：主菜', '2020-12-17 11:45:05', 7, 1, 1, '阿发发a\'faf');
INSERT INTO `t_blog` VALUES (6, b'0', b'0', '1. 案例需求：\r\n    1. 访问带有验证码的登录页面login.jsp\r\n    2. 用户输入用户名，密码以及验证码。\r\n        * 如果用户名和密码输入有误，跳转登录页面，提示:用户名或密码错误\r\n        * 如果验证码输入有误，跳转登录页面，提示：验证码错误\r\n        * 如果全部输入正确，则跳转到主页success.jsp，显示：用户名,欢迎您\r\n\r\n\r\n2. 分析：', NULL, '/images/a3.jpg', '45', b'0', b'1', b'0', '案例：验证码', '2020-12-17 11:20:34', 3, 1, 1, NULL);
INSERT INTO `t_blog` VALUES (7, b'1', b'1', '2.1 Spring程序开发步骤\r\n①导入 Spring 开发的基本包坐标\r\n\r\n②编写 Dao 接口和实现类\r\n\r\n③创建 Spring 核心配置文件\r\n\r\n④在 Spring 配置文件中配置 UserDaoImpl\r\n\r\n⑤使用 Spring 的 API 获得 Bean 实例\r\n\r\n2.2 导入Spring开发的基本包坐标\r\n<properties>\r\n    <spring.version>5.0.5.RELEASE</spring.version>\r\n</properties>\r\n<!--导入spring的context坐标，context依赖core、beans、expression-->\r\n<dependencies> \r\n    <dependency>  \r\n        <groupId>org.springframework</groupId> \r\n        <artifactId>spring-context</artifactId> \r\n        <version>${spring.version}</version>\r\n    </dependency>\r\n</dependencies>\r\n2.3 编写Dao接口和实现类\r\npublic interface UserDao {  \r\n    public void save();\r\n}\r\n\r\npublic class UserDaoImpl implements UserDao {  \r\n        @Override  \r\n        public void save() {\r\n            System.out.println(\"UserDao save method running....\");\r\n    }\r\n}\r\n2.4 创建Spring核心配置文件\r\n在类路径下（resources）创建applicationContext.xml配置文件\r\n\r\n<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n<beans xmlns=\"http://www.springframework.org/schema/beans\"                        xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\r\nxsi:schemaLocation=\"\r\n    http://www.springframework.org/schema/beans                       http://www.springframework.org/schema/beans/spring-beans.xsd\">\r\n</beans>\r\n2.5 在Spring配置文件中配置UserDaoImpl\r\n<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n<beans xmlns=\"http://www.springframework.org/schema/beans\"                        xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\r\nxsi:schemaLocation=\"\r\n    http://www.springframework.org/schema/beans                       http://www.springframework.org/schema/beans/spring-beans.xsd\">\r\n   <bean id=\"userDao\" class=\"com.itheima.dao.impl.UserDaoImpl\"></bean>\r\n</beans>\r\n2.6 使用Spring的API获得Bean实例\r\n@Test\r\npublic void test1(){\r\n        ApplicationContext applicationContext = new  \r\n             ClassPathXmlApplicationContext(\"applicationContext.xml\");\r\n             UserDao userDao = (UserDao) applicationContext.getBean(\"userDao\");                    userDao.save();\r\n }', NULL, '/images/a3.jpg', '45', b'0', b'1', b'1', 'spring快速入门', '2020-12-17 12:25:35', 2, 3, 1, 'spring快速入门');
INSERT INTO `t_blog` VALUES (8, b'0', b'0', '3.1 Bean标签基本配置\r\n用于配置对象交由Spring 来创建。\r\n\r\n# # > > 默认情况下它调用的是类中的无参构造函数，如果没有无参构造函数则不能创建成功。****\r\n\r\n基本属性：\r\n\r\nid：Bean实例在Spring容器中的唯一标识\r\n\r\nclass：Bean的全限定名称\r\n\r\n3.2 Bean标签范围配置\r\nscope:指对象的作用范围，取值如下：\r\n\r\n取值范围	说明\r\nsingleton	默认值，单例的\r\nprototype	多例的\r\nrequest	WEB 项目中，Spring 创建一个 Bean 的对象，将对象存入到 request 域中\r\nsession	WEB 项目中，Spring 创建一个 Bean 的对象，将对象存入到 session 域中\r\nglobal session	WEB 项目中，应用在 Portlet 环境，如果没有 Portlet 环境那么globalSession 相当于 session\r\n1）当scope的取值为singleton时\r\n\r\n​ Bean的实例化个数：1个\r\n\r\n​ Bean的实例化时机：当Spring核心文件被加载时，实例化配置的Bean实例\r\n\r\n​ Bean的生命周期：\r\n\r\n对象创建：当应用加载，创建容器时，对象就被创建了\r\n\r\n对象运行：只要容器在，对象一直活着\r\n\r\n对象销毁：当应用卸载，销毁容器时，对象就被销毁了\r\n\r\n2）当scope的取值为prototype时\r\n\r\n​ Bean的实例化个数：多个\r\n\r\n​ Bean的实例化时机：当调用getBean()方法时实例化Bean\r\n\r\n对象创建：当使用对象时，创建新的对象实例\r\n\r\n对象运行：只要对象在使用中，就一直活着\r\n\r\n对象销毁：当对象长时间不用时，被 Java 的垃圾回收器回收了', NULL, '/images/a3.jpg', '转载', b'0', b'0', b'0', 'Spring配置文件', '2020-12-17 12:30:29', 0, 3, 1, 'Spring配置文件');
INSERT INTO `t_blog` VALUES (9, b'0', b'0', '# ***3.5 Bean的依赖注入入门***\r\n①创建 UserService，UserService 内部在调用 UserDao的save() 方法\r\n\r\npublic class UserServiceImpl implements UserService {\r\n    @Override\r\n    public void save() {\r\n         ApplicationContext applicationContext = new \r\n                 ClassPathXmlApplicationContext(\"applicationContext.xml\");                      UserDao userDao = (UserDao) applicationContext.getBean(\"userDao\");    \r\n          userDao.save();\r\n     }\r\n }\r\n②将 UserServiceImpl 的创建权交给 Spring\r\n\r\n<bean id=\"userService\" class=\"com.itheima.service.impl.UserServiceImpl\"/>\r\n③从 Spring 容器中获得 UserService 进行操作\r\n\r\nApplicationContext applicationContext = new ClassPathXmlApplicationContext(\"applicationContext.xml\");\r\nUserService userService = (UserService) applicationContext.getBean(\"userService\");\r\nuserService.save();', NULL, '/images/a3.jpg', '翻译', b'0', b'0', b'1', '3.5 Bean的依赖注入入门', '2020-12-17 12:34:00', 1, 3, 1, '3.5 Bean的依赖注入入门');
INSERT INTO `t_blog` VALUES (12, b'0', b'0', '## 3.6 Bean的依赖注入概念\r\n依赖注入（Dependency Injection）：它是 Spring 框架核心 IOC 的具体实现。\r\n\r\n在编写程序时，通过控制反转，把对象的创建交给了 Spring，但是代码中不可能出现没有依赖的情况。\r\n\r\nIOC 解耦只是降低他们的依赖关系，但不会消除。例如：业务层仍会调用持久层的方法。\r\n\r\n那这种业务层和持久层的依赖关系，在使用 Spring 之后，就让 Spring 来维护了。\r\n\r\n简单的说，就是坐等框架把持久层对象传入业务层，而不用我们自己去获取', NULL, '/images/a3.jpg', '翻译', b'0', b'0', b'0', '## 3.6 Bean的依赖注入概念', '2020-12-17 12:40:20', 0, 3, 1, '## 3.6 Bean的依赖注入概念');
INSERT INTO `t_blog` VALUES (15, b'0', b'0', '## 3.7 Bean的依赖注入方式\r\n①构造方法\r\n\r\n​ 创建有参构造\r\n\r\npublic class UserServiceImpl implements UserService {\r\n@Override\r\npublic void save() {\r\nApplicationContext applicationContext = new \r\n                 ClassPathXmlApplicationContext(\"applicationContext.xml\");       UserDao userDao = (UserDao) applicationContext.getBean(\"userDao\");    \r\n          userDao.save();\r\n    }\r\n }\r\n​ 配置Spring容器调用有参构造时进行注入\r\n\r\n<bean id=\"userDao\" class=\"com.itheima.dao.impl.UserDaoImpl\"/>\r\n<bean id=\"userService\" class=\"com.itheima.service.impl.UserServiceImpl\">                     <constructor-arg name=\"userDao\" ref=\"userDao\"></constructor-arg>\r\n</bean>', NULL, '/images/a3.jpg', '45', b'0', b'0', b'0', '## 3.7 Bean的依赖注入方式', '2020-12-17 13:07:06', 17, 1, 1, 'sff');
INSERT INTO `t_blog` VALUES (16, b'0', b'0', '3.8 Bean的依赖注入的数据类型\r\n上面的操作，都是注入的引用Bean，处了对象的引用可以注入，普通数据类型，集合等都可以在容器中进行注入。\r\n\r\n注入数据的三种数据类型\r\n\r\n普通数据类型\r\n\r\n引用数据类型\r\n\r\n集合数据类型\r\n\r\n其中引用数据类型，此处就不再赘述了，之前的操作都是对UserDao对象的引用进行注入的，下面将以set方法注入为例，演示普通数据类型和集合数据类型的注入。\r\n\r\nBean的依赖注入的数据类型\r\n\r\n（1）普通数据类型的注入', '2020-12-17 12:58:32', '/images/a3.jpg', '45', b'0', b'0', b'0', '3.8 Bean的依赖注入的数据类型', '2020-12-17 12:58:32', 0, 1, 1, 'asf');
INSERT INTO `t_blog` VALUES (17, b'0', b'0', '4. spring相关API\r\n4.1 ApplicationContext的继承体系\r\napplicationContext：接口类型，代表应用上下文，可以通过其实例获得 Spring 容器中的 Bean 对象\r\n\r\n4.2 ApplicationContext的实现类\r\n1）ClassPathXmlApplicationContext\r\n\r\n​ 它是从类的根路径下加载配置文件 推荐使用这种\r\n\r\n2）FileSystemXmlApplicationContext\r\n\r\n​ 它是从磁盘路径上加载配置文件，配置文件可以在磁盘的任意位置。\r\n\r\n3）AnnotationConfigApplicationContext当使用注解配置容器对象时，需要使用此类来创建 spring 容器。它用来读取注解', '2020-12-17 13:17:37', 'https://unsplash.it/800/450?image=1005', '转载', b'0', b'1', b'0', 'spring相关API', '2020-12-17 13:17:37', 9, 3, 1, 'adf');
INSERT INTO `t_blog` VALUES (19, b'0', b'1', '# Spacedesk是免费的屏幕共享工具\r\n\r\n\r\n\r\n# 需要用到：\r\n```c\r\n工具：一个装有spacedesk的电脑，一个装有spacedesk的手机（iPad）\r\n环境：电脑和手机需要处于同一WIFI(局域网)\r\n```\r\n\r\n\r\n\r\n\r\n\r\n# 使用过程可能出现的问题：\r\n## 1.启动：\r\n\r\n - PC端spacedesk处于“ON”，然后手机端spacedesk里可直接连接\r\n\r\n## 2.使用情景：\r\n\r\n - 手机可选择作为电脑的扩展屏幕或者复制屏幕\r\n - 选择哪种使用方式可在电脑端 设置-显示中选择\r\n\r\n\r\n## 3.手机分辨率：\r\n\r\n - PC端 设置-显示 中可以设置第二屏幕的分辨率\r\n - 手机端spacedesk中setting 可设置屏幕分辨率\r\n\r\n## 4.手机屏幕易旋转：\r\n\r\n - 手机端spacedesk中setting 可设置\r\n\r\n## 5.spacedesk无法正常关闭\r\n\r\n<font color=#999AAA >1.在系统服务中将spacedesk设置为手动启动\r\n2.自定义一个bat文件用于开关spacedesk服务\r\n\r\n> 双击bat文件可以在软件运行的时候停止，也可以在软件停止的时候启动。\r\n\r\n```bash\r\n@ echo off\r\n%1 %2\r\nver|find \"5.\">nul&&goto :Admin\r\nmshta vbscript:createobject(\"shell.application\").shellexecute(\"%~s0\",\"goto :Admin\",\"\",\"runas\",1)(window.close)&goto :eof\r\n:Admin\r\nfor /f \"skip=3 tokens=4\" %%i in (\'sc query spacedeskService\') do set \"zt=%%i\" &goto :next\r\n:next\r\nif /i \"%zt%\"==\"RUNNING\" (\r\nnet stop spacedeskService\r\n) else (\r\nnet start spacedeskService\r\n)\r\necho \r\n```\r\n\r\n\r\n<hr style=\" border:solid; width:100px; height:1px;\" color=#000000 size=1\">\r\n\r\n# 引用\r\n<font color=#999AAA >参考于:                              \r\n> https://blog.csdn.net/qq_44602438/article/details/105755178\r\nhttps://blog.csdn.net/weixin_43262513/article/details/105945491', '2020-12-23 10:04:45', '/images/a3.jpg', '原创', b'0', b'1', b'1', '电脑屏幕拓展——SpaceDesk', '2021-01-19 03:47:15', 75, 13, 1, 'Spacedesk是免费的屏幕共享工具');

-- ----------------------------
-- Table structure for t_blog_tags
-- ----------------------------
DROP TABLE IF EXISTS `t_blog_tags`;
CREATE TABLE `t_blog_tags`  (
  `blogs_id` bigint(20) NOT NULL,
  `tags_id` bigint(20) NOT NULL,
  INDEX `FK5feau0gb4lq47fdb03uboswm8`(`tags_id`) USING BTREE,
  INDEX `FKh4pacwjwofrugxa9hpwaxg6mr`(`blogs_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of t_blog_tags
-- ----------------------------
INSERT INTO `t_blog_tags` VALUES (2, 1);
INSERT INTO `t_blog_tags` VALUES (3, 1);
INSERT INTO `t_blog_tags` VALUES (5, 3);
INSERT INTO `t_blog_tags` VALUES (5, 1);
INSERT INTO `t_blog_tags` VALUES (6, 3);
INSERT INTO `t_blog_tags` VALUES (6, 1);
INSERT INTO `t_blog_tags` VALUES (7, 7);
INSERT INTO `t_blog_tags` VALUES (7, 6);
INSERT INTO `t_blog_tags` VALUES (8, 3);
INSERT INTO `t_blog_tags` VALUES (8, 1);
INSERT INTO `t_blog_tags` VALUES (9, 3);
INSERT INTO `t_blog_tags` VALUES (10, 1);
INSERT INTO `t_blog_tags` VALUES (9, 1);
INSERT INTO `t_blog_tags` VALUES (10, 3);
INSERT INTO `t_blog_tags` VALUES (12, 3);
INSERT INTO `t_blog_tags` VALUES (12, 1);
INSERT INTO `t_blog_tags` VALUES (15, 1);
INSERT INTO `t_blog_tags` VALUES (16, 3);
INSERT INTO `t_blog_tags` VALUES (17, 1);
INSERT INTO `t_blog_tags` VALUES (19, 1);

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `blog_id` bigint(20) NULL DEFAULT NULL,
  `parent_comment_id` bigint(20) NULL DEFAULT NULL,
  `admin_comment` bit(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKke3uogd04j4jx316m1p51e05u`(`blog_id`) USING BTREE,
  INDEX `FK4jj284r3pb7japogvo6h72q95`(`parent_comment_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (3, '/images/cat.jpg', 'test', '2021-01-18 09:26:52', '1443937284@qq.com', '三金', 19, NULL, b'0');
INSERT INTO `t_comment` VALUES (4, '/images/cat.jpg', '哈佳', '2021-01-18 10:23:14', '1443937284@qq.com', '123', 19, 3, b'0');
INSERT INTO `t_comment` VALUES (5, '/images/cat.jpg', '454', '2021-01-18 10:23:36', '1443937284@qq.com', '555', 19, 3, b'0');
INSERT INTO `t_comment` VALUES (6, '/images/cat.jpg', '233', '2021-01-18 10:23:44', '1443937284@qq.com', '555', 19, 4, b'0');
INSERT INTO `t_comment` VALUES (7, '/images/cat.jpg', '大大', '2021-01-18 10:24:21', '1443937284@qq.com', '俺得', 19, NULL, b'0');
INSERT INTO `t_comment` VALUES (8, '/images/cat.jpg', '不错', '2021-01-18 10:24:39', '1443937284@qq.com', '啊', 19, NULL, b'0');
INSERT INTO `t_comment` VALUES (9, '/images/cat.jpg', '111', '2021-01-18 10:24:45', '1443937284@qq.com', '啊', 19, 8, b'0');
INSERT INTO `t_comment` VALUES (10, '/images/cat.jpg', '啊大大', '2021-01-18 10:25:02', '1443937284@qq.com', '啊阿达', 19, 9, b'0');
INSERT INTO `t_comment` VALUES (11, '/images/cat.jpg', 'adad', '2021-01-19 03:22:59', '781673272@qq.com', 'aaaaa', 19, 10, b'0');
INSERT INTO `t_comment` VALUES (12, '/images/cat.jpg', '454545', '2021-01-19 03:23:10', '781673272@qq.com', 'aaaaa', 19, 5, b'0');
INSERT INTO `t_comment` VALUES (13, '/images/cat.jpg', '5545', '2021-01-19 03:23:26', '781673272@qq.com', 'aaaaa', 19, 3, b'0');
INSERT INTO `t_comment` VALUES (14, '/images/a1.jpg', '管理员评论', '2021-01-19 03:25:54', '1443937284@qq.com', '三金', 19, NULL, b'1');
INSERT INTO `t_comment` VALUES (15, '/images/a1.jpg', 'haha', '2021-01-19 03:32:25', '1443937284@qq.com', '三金', 19, 14, b'1');
INSERT INTO `t_comment` VALUES (16, '/images/a1.jpg', 'test', '2021-01-19 05:21:22', '1443937284@qq.com', '三金', 2, NULL, b'1');

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES (1, '方法');
INSERT INTO `t_tag` VALUES (3, '补充');
INSERT INTO `t_tag` VALUES (4, '商品后台管理系统');
INSERT INTO `t_tag` VALUES (6, '技巧');
INSERT INTO `t_tag` VALUES (7, '技术');

-- ----------------------------
-- Table structure for t_type
-- ----------------------------
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_type
-- ----------------------------
INSERT INTO `t_type` VALUES (1, '错误日志');
INSERT INTO `t_type` VALUES (2, '认知升级');
INSERT INTO `t_type` VALUES (3, 'Java');
INSERT INTO `t_type` VALUES (4, 'html');
INSERT INTO `t_type` VALUES (5, 'js');
INSERT INTO `t_type` VALUES (6, 'c++');
INSERT INTO `t_type` VALUES (7, 'Spring');
INSERT INTO `t_type` VALUES (8, 'springBoot');
INSERT INTO `t_type` VALUES (9, 'css');
INSERT INTO `t_type` VALUES (13, '拓展');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, '/images/a1.jpg', '2020-12-14 16:13:59', '1443937284@qq.com', '三金', '16bf688751f6ed077e982cbb5382f07c', 1, '2020-12-14 16:14:33', 'sanjin');
INSERT INTO `t_user` VALUES (2, '/images/a3.jpg', '2020-12-14 18:47:20', 'sanjin123', 'test', '098f6bcd4621d373cade4e832627b4f6', 1, '2020-12-14 18:47:44', 'test');

SET FOREIGN_KEY_CHECKS = 1;

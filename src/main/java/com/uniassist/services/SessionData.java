package com.uniassist.services;

import java.util.HashMap;
import java.util.concurrent.atomic.AtomicInteger;

public final class SessionData {
    public static AtomicInteger count;
    public static HashMap<String, AtomicInteger> pageCounter = new HashMap<String, AtomicInteger>() {{
        put("profile", new AtomicInteger());
        put("edit", new AtomicInteger());
        put("index", new AtomicInteger(-2));
        put("how-to-apply", new AtomicInteger());
        put("faq", new AtomicInteger());
        put("about", new AtomicInteger());
        put("login", new AtomicInteger());
        put("register", new AtomicInteger());
    }};
}

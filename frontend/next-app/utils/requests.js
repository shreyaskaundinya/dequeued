export const makePostRequest = async (
    endpoint,
    data,
    successCallback,
    errorCallback
) => {
    const res = await fetch(endpoint, {
        method: 'POST',
        body: JSON.stringify(data),
    });

    const resData = await res.json();
    if (res.ok) {
        successCallback(resData);
    } else {
        errorCallback(resData);
    }
    return resData;
};

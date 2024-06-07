import { Then } from '@cucumber/cucumber';
import { getElementPath } from '../support/web-element-helper';
import { ElementKey } from '../../env/globals';
import { ScenarioWorld } from '../setup/world';
import { waitFor, waitForResult } from '../support/wait-for-behavior';

Then(
  /^the element: "([^"]*)"(?: with value "([^"]*)")? is( not)? visible on the page$/,
  async function(this: ScenarioWorld, elementKey: ElementKey, value: string, negate: boolean) {
    const {

      screen: { page },
      globalConfig

    } = this;

    let pathToElement: string;

    if (value) {
      pathToElement = getElementPath(page, elementKey, globalConfig);
      pathToElement = pathToElement.replace('{{value}}', value)
    } else {
      pathToElement = getElementPath(page, elementKey, globalConfig);
    }

    await waitFor(async () => {
      const isElementVisible = (await page.$(pathToElement)) != null;
      if (isElementVisible === !negate) {
        return waitForResult.PASS
      } else {
        return waitForResult.ELEMENT_NOT_AVAILABLE
      }
    });

  }
);
